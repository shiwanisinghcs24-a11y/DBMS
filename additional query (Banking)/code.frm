SHOW databases;
use shiwani2;
show tables;
create table Branch(BRANCHNAME varchar(30), BRANCHCITY varchar(30),ASSESTS int,primary key(BRANCHNAME));
create table BankAccount(ACCNO int, BRANCHNAME varchar(30), BALANCE int,primary key(ACCNO), foreign key(BRANCHNAME) references Branch(BRANCHNAME));
create table BankCustomer(CUSTOMERNAME varchar(30),CUSTOMERSTREET varchar(30),CUSTOMERCITY varchar(30),primary key(CUSTOMERNAME));
create table Deposit(CUSTOMERNAME varchar(30),ACCNO int, foreign key(ACCNO) references BankAccount(ACCNO), foreign key(CUSTOMERNAME) references BANKCUSTOMER(CUSTOMERNAME));
create table Loan(LOANNUMBER int,BRANCHNAME varchar(30),AMOUNT int,primary key(LOANNUMBER), foreign key(BRANCHNAME) references Branch(BRANCHNAME));
create table Borrower(Customername varchar(30),LOANNUMBER int, foreign key(LOANNUMBER) references Loan(LOANNUMBER));

insert into Branch values('SBI_Chamrajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',3000);
insert into Branch values('SBI_ParliamentRoad','Delhi',10000);
insert into Branch values('SBI_Jantarmantar','Delhi',20000);

insert into BankAccount values(1,'SBI_Chamrajpet',2000);
insert into BankAccount values(2,'SBI_ResidencyRoad',5000);
insert into BankAccount values(3,'SBI_ShivajiRoad',6000);
insert into BankAccount values(4,'SBI_ParliamentRoad',9000);
insert into BankAccount values(5,'SBI_Jantarmantar',8000);
insert into BankAccount values(6,'SBI_ShivajiRoad',4000);
insert into BankAccount values(8,'SBI_ResidencyRoad',4000);
insert into BankAccount values(9,'SBI_ParliamentRoad',3000);
insert into BankAccount values(10,'SBI_ResidencyRoad',5000);
insert into BankAccount values(11,'SBI_Jantarmantar',2000);

insert into BankCustomer values('Avinash','Bull_Temple_Road','Bangalore');
insert into BankCustomer values('Dinesh','Bannergatta_Road','Bangalore');
insert into BankCustomer values('Mohan','NationalCollege_Road','Bangalore');
insert into BankCustomer values('Nikil','Akbar_Road','Delhi');
insert into BankCustomer values('Ravi','Prithviraj_Road','Delhi');

insert into Deposit values('Avinash',1);
insert into Deposit values('Dinesh',2);
insert into Deposit values('Nikil',4);
insert into Deposit values('Ravi',5);
insert into Deposit values('Avinash',8);
insert into Deposit values('Nikil',9);
insert into Deposit values('Dinesh',10);
insert into Deposit values('Nikil',11);


insert into Loan values(1,'SBI_Chamrajpet',1000);
insert into Loan values(2,'SBI_ResidencyRoad',2000);
insert into Loan values(3,'SBI_ShivajiRoad',3000);
insert into Loan values(4,'SBI_ParliamentRoad',4000);
insert into Loan values(5,'SBI_Jantarmantar',5000);

insert into borrower values("Nikil",1);
insert into borrower values("Dinesh",2);
insert into borrower values("Ravi",3);
insert into borrower values("Avinash",4);
insert into borrower values("Mohan",5);

SELECT c.CUSTOMERNAME
FROM BankCustomer c
JOIN Deposit d ON c.CUSTOMERNAME = d.CUSTOMERNAME
JOIN BankAccount b ON d.ACCNO = b.ACCNO
JOIN Branch br ON b.BRANCHNAME = br.BRANCHNAME
WHERE br.BRANCHCITY = 'Delhi'
GROUP BY c.CUSTOMERNAME
HAVING COUNT(DISTINCT br.BRANCHNAME) = (SELECT COUNT(*) FROM Branch WHERE BRANCHCITY = 'Delhi');

DELETE FROM BankAccount
WHERE BRANCHNAME IN (
    SELECT BRANCHNAME
    FROM Branch
    WHERE BRANCHCITY = 'Bombay'
);

SELECT * FROM LOAN ORDER BY AMOUNT DESC;
(select customername from borrower) union (select customername from BankCustomer);

CREATE VIEW BRANCH_TOTAL_LOAN (BRANCH_NAME, TOTAL_LOAN) AS SELECT
BRANCHNAME, SUM(AMOUNT) FROM LOAN GROUP BY BRANCHNAME;

UPDATE BANKACCOUNT SET BALANCE=BALANCE *1.05;
select accno,branchname,balance from bankaccount;
SELECT BRANCHNAME, ASSESTS / 100000.0 AS "assets in lakhs" FROM Branch;

select * from Branch;
select * from BankAccount;
select * from BankCustomer;
select * from Deposit;
select * from Loan;
select * from borrower;
select * from BRANCH_TOTAL_LOAN;

drop table branch;
drop table bankaccount;
drop table bankcustomer;
drop table deposit;
drop table loan;



