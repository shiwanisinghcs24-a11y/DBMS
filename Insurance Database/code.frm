use shiwani;
create table person (driver_id varchar(10),name varchar(20), address varchar(30), primary key(driver_id));



create table car(reg_num varchar(10),model varchar(10),year int, primary
key(reg_num));

create table accident(report_num int, accident_date date, location
varchar(20),primary key(report_num));

create table owns(driver_id varchar(10),reg_num varchar(10),primary key(driver_id, reg_num),foreign key(driver_id) references person(driver_id),foreign key(reg_num) references car(reg_num));

create table participated(driver_id varchar(10), reg_num varchar(10),report_num int, damage_amount int,primary key(driver_id, reg_num, report_num),foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),foreign key(report_num) references accident(report_num));

insert into accident values (11, '2003-01-01','Mysore Road');

insert into accident values (12,'2004-02-02','South end Circle');

insert into accident values (13,'2003-01-21','Bull temple Road');

insert into accident values (14,'2008-02-17','Mysore Road');

insert into accident values (15,'2004-03-05','Kanakpura Road');




insert into car values ('PA0823764', 'abcd','2001');

insert into  car  values ('KA267476','CDEF','2002');

insert into car values ('AS1633318','XYZ','2005');

insert into  car  values ('KS3764','IJK','2006');

insert into  car  values ('PL3644623','qrs','2008');


insert into person values ('KO1','kunal','pune');

insert into person  values ('AO1','ankit','KTM');

insert into person values ('PO2','ADVIK','DELHI');

insert into person  values ('GSV3','ARK','MUMBAI');

insert into person  values ('FYP4','VENU','PATNA');



insert into owns values ('KO1','PA0823764');

insert into owns   values ('AO1','KA267476');

insert into owns  values ('PO2','AS1633318');

insert into owns   values ('GSV3','KS3764');

insert into owns   values ('FYP4','PL3644623');


insert into participated values('KO1','PA0823764',11,10000);
insert into participated values('AO1','KA267476',12,12000);
insert into participated values('PO2','AS1633318',13,15000);
insert into participated values('GSV3','KS3764',14,16000);
insert into participated values('FYP4','PL3644623',15,13000);

insert into accident values(16,'2008-03-08','Domlur');


update participated set damage_amount=25000
where reg_num='KS3764'and report_num=14;


select count(distinct driver_id) CNT
from participated a, accident b
where a.report_num=b.report_num and b.accident_date like '2008%';

SELECT * FROM PARTICIPATED ORDER BY DAMAGE_AMOUNT DESC;
SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATED;

SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID AND
DAMAGE_AMOUNT > (SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATED);

SELECT MAX(DAMAGE_AMOUNT) FROM PARTICIPATED;

SELECT * FROM accident;
SELECT * FROM person;
SELECT * FROM car;
SELECT * FROM owns;
SELECT * FROM participated;







