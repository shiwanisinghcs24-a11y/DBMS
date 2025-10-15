create database IF NOT exists shiwani2;
use shiwani2;

create table Branch(BRANCHNAME varchar(30), BRANCHCITY varchar(30),ASSESTS int,primary key(BRANCHNAME));
create table BankAccount(ACCNO int, BRANCHNAME varchar(30), BALANCE int,primary key(ACCNO), foreign key(BRANCHNAME) references Branch(BRANCHNAME));
create table BankCustomer(CUSTOMERNAME varchar(30),CUSTOMERSTREET varchar(30),CUSTOMERCITY varchar(30),primary key(CUSTOMERNAME));
create table Deposit(CUSTOMERNAME varchar(30),ACCNO int, foreign key(ACCNO) references BankAccount(ACCNO), foreign key(CUSTOMERNAME) references BANKCUSTOMER(CUSTOMERNAME));
create table Loan(LOANNUMBER int,BRANCHNAME varchar(30),AMOUNT int, foreign key(BRANCHNAME) references Branch(BRANCHNAME));

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



SELECT d.CUSTOMERNAME FROM Deposit d JOIN BankAccount a ON d.ACCNO = a.ACCNO GROUP BY d.CUSTOMERNAME HAVING COUNT(d.ACCNO) >= 2;



SELECT d.CUSTOMERNAME FROM Deposit d JOIN BankAccount a ON d.ACCNO = a.ACCNO
JOIN Branch b ON a.BRANCHNAME = b.BRANCHNAME
WHERE b.BRANCHCITY = 'Delhi'
GROUP BY d.CUSTOMERNAME
HAVING COUNT(DISTINCT b.BRANCHNAME) = (
    SELECT COUNT(*) 
    FROM Branch 
    WHERE BRANCHCITY = 'Delhi'
);



DELETE a
FROM BankAccount a
JOIN Branch b ON a.BRANCHNAME = b.BRANCHNAME
WHERE b.BRANCHCITY = 'Bombay';



select * from Branch;
select * from BankAccount;
select * from BankCustomer;
select * from Deposit;
select * from Loan;
