CREATE TABLE DEPARTMENT (
 dname varchar(25) not null,
 dnumber int(10) not null,
 mgrstartdate date,
 primary key (dnumber));

CREATE TABLE EMPLOYEE (
 fname varchar(15) not null, 
 minit varchar(1),
 lname varchar(15) not null,
 ssn INT(15), 
 bdate date,
 address varchar(50),
 sex char(10),
 salary decimal(10,2),
 DNO INT(10),
 primary key (ssn),
 foreign key (dno) references DEPARTMENT(dnumber));

CREATE TABLE DEPENDENT (
 essn INT(9),
 dependent_name varchar(15),
 sex char(10),
 bdate date,
 relationship varchar(8),
foreign key (essn) references EMPLOYEE(ssn));

CREATE TABLE DEPT_LOCATIONS (
 dnumber int(10),
 dlocation varchar(15), 
foreign key (dnumber) references DEPARTMENT(dnumber));

CREATE TABLE PROJECT (
 pname varchar(25) not null,
 pnumber int(10),
 plocation varchar(15),
 dnum int(10),
 primary key (pnumber),
 foreign key (dnum) references DEPARTMENT(dnumber));

CREATE TABLE WORKS_ON (
 essn INT(9),
 pno int(10),
 hours decimal(4,1),
foreign key (essn) references EMPLOYEE(ssn),
foreign key (pno) references PROJECT(pnumber));

INSERT INTO DEPARTMENT VALUES ('Research','5','1978-05-22');
INSERT INTO DEPARTMENT VALUES ('Administration','4','1985-01-01');
INSERT INTO DEPARTMENT VALUES ('Headquarters','1','1971-06-19');
INSERT INTO DEPARTMENT VALUES ('Software','6','1999-05-15');
INSERT INTO DEPARTMENT VALUES ('Hardware','7','1998-05-15');
INSERT INTO DEPARTMENT VALUES ('Sales','8','1997-01-01');

INSERT INTO EMPLOYEE VALUES ('Bob','B','Bender','666666600','1968-04-17','8794 Garfield, Chicago, IL','M','55000.00',8); 
INSERT INTO EMPLOYEE VALUES ('James','E','Borg','888665555','1927-11-10','450 Stone, Houston, TX','M','55000.00','1');
INSERT INTO EMPLOYEE VALUES ('Alex','D','Freed','444444400','1950-10-09','4333 Pillsbury, Milwaukee, WI','M','56000.00','7');
INSERT INTO EMPLOYEE VALUES ('Ahmad','V','Jabbar','987987987','1959-03-29','980 Dallas, Houston, TX','M','49000.00','4');
INSERT INTO EMPLOYEE VALUES ('Joyce','A','English','453453453','1962-07-31','5631 Rice, Houston, TX','F','25000.00','5'); 
INSERT INTO EMPLOYEE VALUES ('Jared','D','James','111111100','1966-10-10','123 Peachtree, Atlanta, GA','M','46000.00','6');

INSERT INTO DEPENDENT VALUES ('888665555','Alice','F','1976-04-05','Daughter');
INSERT INTO DEPENDENT VALUES ('987987987','Joy','F','1948-05-03','Son');
INSERT INTO DEPENDENT VALUES ('666666600','Michael','M','1978-01-01','Son');
INSERT INTO DEPENDENT VALUES ('111111100','Elizabeth','F',Null,'Spouse');
INSERT INTO DEPENDENT VALUES ('444444400','Johnny','M','1997-04-04','Son');
INSERT INTO DEPENDENT VALUES ('444444400','Tommy','M','1999-06-07','Son');

INSERT INTO DEPT_LOCATIONS VALUES ('1','Houston');
INSERT INTO DEPT_LOCATIONS VALUES ('4','Stafford');
INSERT INTO DEPT_LOCATIONS VALUES ('5','Houston');
INSERT INTO DEPT_LOCATIONS VALUES ('5','Sugarland');
INSERT INTO DEPT_LOCATIONS VALUES ('6','Atlanta');
INSERT INTO DEPT_LOCATIONS VALUES ('7','Chicago');
INSERT INTO DEPT_LOCATIONS VALUES ('8','NewYork');

INSERT INTO PROJECT VALUES ('ProductA','2','Sugarland','5');
INSERT INTO PROJECT VALUES ('ProductB','3','Houston','5');
INSERT INTO PROJECT VALUES ('ProductC','4','Stafford','4');
INSERT INTO PROJECT VALUES ('ProductD','5','Houston','1');
INSERT INTO PROJECT VALUES ('ProductE','7','Stafford','4');
INSERT INTO PROJECT VALUES ('ProductF','1','Jackson','6');
INSERT INTO PROJECT VALUES ('ProductG','6','Phoenix','7');

INSERT INTO WORKS_ON VALUES ('666666600','1','10.0');
INSERT INTO WORKS_ON VALUES ('666666600','2','20.0');
INSERT INTO WORKS_ON VALUES ('888665555','2','30.0');
INSERT INTO WORKS_ON VALUES ('888665555','3','15.0');
INSERT INTO WORKS_ON VALUES ('987987987','5','35.0');
INSERT INTO WORKS_ON VALUES ('987987987','4','05.0');
INSERT INTO WORKS_ON VALUES ('453453453','3','04.0');
INSERT INTO WORKS_ON VALUES ('453453453','1','08.0');
INSERT INTO WORKS_ON VALUES ('111111100','6','12.0');
INSERT INTO WORKS_ON VALUES ('111111100','7','15.0');
INSERT INTO WORKS_ON VALUES ('444444400','6','18.0');
INSERT INTO WORKS_ON VALUES ('444444400','4','19.0');

alter table department add mgrssn int(10);

alter table department add foreign key(mgrssn) references employee(ssn);

alter table employee add superssn int(10);

alter table employee add foreign key(superssn) references employee(ssn);

update department set mgrssn=111111100 where dnumber=1;

update employee set superssn=111111100 where dno=1;

i. Retrieve the name and address of all employees who work for the ‘Research’ department.

select e.fname,e.address 
from employee e, department d 
where d.dname="Research" and d.dnumber = e.dno;

ii. For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.

select p.pnumber,p.dnum,e.lname,e.address,e.bdate 
from project p, department d, employee e 
where p.plocation="Stafford" and p.dnum= d.dnumber and d.mgrssn=e.ssn;

iii. For each employee, retrieve the employee’s first and last name and the first and last name of his or her immediate supervisor.

select e.fname,e.lname,s.fname,s.lname 
from employee as e, employee as s 
where s.superssn=e.ssn;

iv. Make a list of all project numbers for projects that involve an employee whose last name is ‘Smith’, either as a worker or as a manager of the department that controls the project.

(select distinct pnumber from project,department,employee where dnum=dnumber and mgrssn=ssn and lname="Smith") 
union
(select distinct pnumber from project,works_on,employee where pnumber=pno and essn=ssn and lname="Smith");

v. Retrieve all employees whose address is in Houston, Texas.

select fname,minit,lname 
from employee 
where address="Houston,Texas,";

vi. Retrieve all employees in department 5 whose salary is between $30,000 and $40,000.

select * from employee where dno=5 and salary >=30000 and salary <=40000;

vii. Retrieve all names of all employee who do not have supervisor

select fname, minit, lname
from employee
where superssn is null;

viii. Retrive the name of each emp who as has dependent with the same first name as same sex as the employee

select E.fname, E.lname
from employee as E
where E.ssn in ( select essn from dependent where E.fname = dependent_name and E.sex = sex);

ix. Retrieve the name of employee who have no depenents

select fname, lname
from employee
where not exists ( select * from dependent where ssn = essn);

ix. Retrieve the name of employee who have at least one depenents

select fname, lname from employee where exists ( select * from dependent where ssn = essn) and exists ( select * from department where ssn = mgrssn);

x. Retrieve the ssn of all employe who work in onproject number 1, 2, and 3

select distinct essn
from works_on
where pno in  (1, 2, 3);

xi. sum max avg min

select sum(salary), max(salary), min(salary), avg(salary)
from employee, department
where dno = dnumber and dname = 'Research';

xii. 

select dno, count(*), avg(salary)
from employee
group by dno;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE database BANK;

USE BANK;

CREATE TABLE BRANCH (
BNAME VARCHAR(10) PRIMARY KEY,
CITY VARCHAR(10),
ASSETS REAL);

INSERT INTO BRANCH VALUES('MAIN','BLR',2500000); 

CREATE TABLE ACCOUNT (
ACCNO INT(10) PRIMARY KEY,
BNAME VARCHAR(10),
BALANCE REAL,
FOREIGN KEY(BNAME) REFERENCES BRANCH(BNAME));

INSERT INTO ACCOUNT VALUES(1,'MAIN',25000);

CREATE TABLE CUST (
CNAME VARCHAR(10) PRIMARY KEY,
CSTREET VARCHAR(10) NOT NULL,
CITY VARCHAR(10) NOT NULL);

INSERT INTO CUST VALUES('STAN','BAKER STREET','BLR');

CREATE TABLE DEPOSITOR (
CNAME VARCHAR(10),
ACCNO INT(10),
PRIMARY KEY(CNAME,ACCNO),
FOREIGN KEY(ACCNO) REFERENCES ACCOUNT(ACCNO) ON DELETE CASCADE,
FOREIGN KEY(CNAME) REFERENCES CUST(CNAME) ON DELETE CASCADE);

INSERT INTO DEPOSITOR VALUES('HOUSE',22);

CREATE TABLE LOAN(
LNO INT(10) PRIMARY KEY,
BNAME VARCHAR(10) NOT NULL,
AMT REAL,
FOREIGN KEY(BNAME) REFERENCES BRANCH(BNAME) ON DELETE CASCADE);

INSERT INTO LOAN VALUES(1,'MAIN',5000);

CREATE TABLE BORROWER(
CNAME VARCHAR(10),
LNO INT(10),
PRIMARY KEY(CNAME, LNO),
FOREIGN KEY(CNAME) REFERENCES CUST(CNAME) ON DELETE CASCADE,
FOREIGN KEY(LNO) REFERENCES LOAN(LNO) ON DELETE CASCADE);

INSERT INTO BORROWER VALUES('ERIC',2);

1)Find all the customers who have at least two accounts at the Main branch.

SELECT customer_name
 FROM depositor d,account a
 WHERE d.accno=a.accno
 AND a.branch_name='Main'
 GROUP BY d.customer_name
 HAVING COUNT(d.customer_name)>=2;

2)Find all the customers who have an account at all the branches located in a specific city.

 SELECT d.customer_name
 FROM account a,branch b,depositor d
 WHERE b.branch_name=a.branch_name AND
 a.accno=d.accno AND
 b.branch_city='c3'
 GROUP BY d.customer_name
 HAVING COUNT(distinct b.branch_name)=(
 SELECT COUNT(branch_name)
 FROM branch
 WHERE branch_city='c3');

3)Demonstrate how you delete all account tuples at every branch located in a specific city.

SELECT * FROM ACCOUNT;

delete from account 
where accno in (select a.accno 
 from account a, branch b 
 where a.branch_name=b.branch_name and b.branch_city='Bangalore');

SELECT * FROM ACCOUNT
