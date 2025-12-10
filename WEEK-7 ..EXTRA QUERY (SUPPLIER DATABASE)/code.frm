use shiwani;
create table SUPPLIERS(sid integer(5) primary key, sname varchar(20), city
varchar(20));
desc SUPPLIERS;

create table PARTS(pid integer(5) primary key, pname varchar(20), color varchar(10));
desc PARTS;

create table CATALOG(sid INTEGER(5), pid INTEGER(5), foreign key(sid)
references SUPPLIERS(sid), foreign key(pid) references PARTS(pid), cost
float(6), primary key(sid, pid));

desc CATALOG;


insert into suppliers values(10001,'Acme Widget','Bangalore');
insert into suppliers values(10002,'Johns','Kolkata');
insert into suppliers values(10003,'Vimal','Mumbai');
insert into suppliers values(10004,'Reliance','Delhi');
insert into suppliers values(10005,'Mahindra','Mumbai');

select * from SUPPLIERS;
commit;

insert into PARTS values(20001,'Book','Red');
insert into PARTS values(20002,'Pen','Red');
insert into PARTS values(20003,'Pencil','Green');
insert into PARTS values(20004,'Mobile','Green');
insert into PARTS values(20005,'Charger','Black');

select * from PARTS;
commit;

insert into CATALOG values(10001, 20001,10);
insert into CATALOG values(10001, 20002,10);
insert into CATALOG values(10001, 20003,30);
insert into CATALOG values(10001, 20004,10);
insert into CATALOG values(10001, 20005,10);

insert into CATALOG values(10002, 20001,10);
insert into CATALOG values(10002, 20002,20);
insert into CATALOG values(10003, 20003,30);
insert into CATALOG values(10004, 20003,40);

select * from CATALOG;


SELECT DISTINCT P.pname
 FROM Parts P, Catalog C
 WHERE P.pid = C.pid;
 
 
 SELECT S.sname
FROM Suppliers S

WHERE
(( SELECT count(P.pid)
FROM Parts P ) =
( SELECT count(C.pid)
FROM Catalog C
WHERE C.sid = S.sid ));

SELECT S.sname
FROM Suppliers S
WHERE
(( SELECT count(P.pid)
FROM Parts P where color='Red') =
( SELECT count(C.pid)
FROM Catalog C, Parts P
WHERE C.sid = S.sid AND
C.pid = P.pid AND P.color ='Red'));

SELECT P.pname
FROM Parts P, Catalog C, Suppliers S
WHERE P.pid = C.pid AND C.sid = S.sid
AND S.sname = 'Acme Widget'
AND NOT EXISTS ( SELECT *

FROM Catalog C1, Suppliers S1
WHERE P.pid = C1.pid AND C1.sid = S1.sid AND
S1.sname<>'Acme Widget');

SELECT DISTINCT C.sid FROM Catalog C
 WHERE C.cost >( SELECT AVG (C1.cost)
 FROM Catalog C1
 WHERE C1.pid = C.pid );
 
 SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX(C1.cost)
FROM Catalog C1
WHERE C1.pid = P.pid);


SELECT p.pid, p.pname, s.sid, s.sname, c.cost
FROM CATALOG c
JOIN PARTS p ON c.pid = p.pid
JOIN SUPPLIERS s ON c.sid = s.sid
WHERE c.cost = (SELECT MAX(cost) FROM CATALOG);

SELECT s.sid, s.sname
FROM SUPPLIERS s
WHERE s.sid NOT IN (
    SELECT c.sid
    FROM CATALOG c
    JOIN PARTS p ON c.pid = p.pid
    WHERE p.color = 'Red'
);

SELECT s.sid, s.sname, SUM(c.cost) AS total_value
FROM SUPPLIERS s
LEFT JOIN CATALOG c ON s.sid = c.sid
GROUP BY s.sid, s.sname;



SELECT p.pid, p.pname, s.sid, s.sname, c.cost
FROM CATALOG c
JOIN PARTS p ON c.pid = p.pid
JOIN SUPPLIERS s ON c.sid = s.sid
WHERE (p.pid, c.cost) IN (
    SELECT pid, MIN(cost)
    FROM CATALOG
    GROUP BY pid
);

CREATE VIEW SupplierPartCount AS
SELECT s.sid, s.sname, COUNT(c.pid) AS total_parts
FROM SUPPLIERS s
LEFT JOIN CATALOG c ON s.sid = c.sid
GROUP BY s.sid, s.sname;

SELECT * FROM SupplierPartCount;

CREATE VIEW MostExpensiveSupplier AS
SELECT p.pid, p.pname, s.sid, s.sname, c.cost
FROM CATALOG c
JOIN PARTS p ON c.pid = p.pid
JOIN SUPPLIERS s ON c.sid = s.sid
WHERE (p.pid, c.cost) IN (
    SELECT pid, MAX(cost)
    FROM CATALOG
    GROUP BY pid
);
SELECT * FROM MostExpensiveSupplier;

DELIMITER $$

CREATE TRIGGER prevent_low_cost
BEFORE INSERT ON CATALOG
FOR EACH ROW
BEGIN
    IF NEW.cost < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cost cannot be less than 1';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER set_default_cost
BEFORE INSERT ON CATALOG
FOR EACH ROW
BEGIN
    IF NEW.cost IS NULL THEN
        SET NEW.cost = 10;   -- default cost
    END IF;
END$$
DELIMITER ;
