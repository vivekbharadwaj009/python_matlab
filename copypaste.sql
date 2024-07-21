CREATE TABLE EMPLOYEE
( Fname           VARCHAR(10)   NOT NULL,
  Minit           CHAR,
  Lname           VARCHAR(20)      NOT NULL,
  Ssn             CHAR(9)          NOT NULL,
  Bdate           DATE,
  Address         VARCHAR(30),
  Sex             CHAR(1),
  Salary          DECIMAL(5),
  Super_ssn       CHAR(9),
  Dno             INT               NOT NULL,
  PRIMARY KEY(Ssn));


CREATE TABLE DEPARTMENT
( Dname           VARCHAR(15)       NOT NULL,
  Dnumber         INT               NOT NULL,
  Mgr_ssn         CHAR(9)           NOT NULL,
  Mgr_start_date  DATE,
  PRIMARY KEY (Dnumber),
  UNIQUE      (Dname),
  FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn) );


CREATE TABLE DEPT_LOCATIONS
( Dnumber         INT               NOT NULL,
  Dlocation       VARCHAR(15)       NOT NULL,
  PRIMARY KEY (Dnumber, Dlocation),
  FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber) );


Create table PROJECT
( pname       varchar(25) not null unique,
  pnumber     int not null primary key,
  plocation   varchar(15),
  dnum        int not null,
  foreign key(dnum) references DEPARTMENT(Dnumber));
   
 
CREATE TABLE WORKS_ON
( Essn            CHAR(9)           NOT NULL,
  Pno             INT               NOT NULL,
  Hours           DECIMAL(3,1)      NOT NULL,
  PRIMARY KEY (Essn, Pno),
  FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
  FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber) );


CREATE TABLE DEPENDENT
( Essn            CHAR(9)           NOT NULL,
  Dependent_name  VARCHAR(15)       NOT NULL,
  Sex             CHAR,
  Bdate           DATE,
  Relationship    VARCHAR(8),
  PRIMARY KEY (Essn, Dependent_name),
  FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn) );


INSERT INTO EMPLOYEE
VALUES ('Franklin','T','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
            ('Alicia','J','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
            ('Jennifer','S','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
            ('Ramesh','K','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
            ('Joyce','A','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
            ('Ahmad','V','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
            ('James','E','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,,1);

INSERT INTO DEPARTMENT
VALUES      ('Research',5,333445555,'1988-05-22'),
            ('Administration',4,987654321,'1995-01-01'),
            ('Headquarters',1,888665555,'1981-06-19');

INSERT INTO PROJECT
VALUES      ('ProductX',1,'Bellaire',5),
            ('ProductY',2,'Sugarland',5),
            ('ProductZ',3,'Houston',5),
            ('Computerization',10,'Stafford',4),
            ('Reorganization',20,'Houston',1),
            ('Newbenefits',30,'Stafford',4);

INSERT INTO WORKS_ON
VALUES     (123456789,1,32.5),
           (123456789,2,7.5),
           (666884444,3,40.0),
           (453453453,1,20.0),
           (453453453,2,20.0),
           (333445555,2,10.0),
           (333445555,3,10.0),
           (333445555,10,10.0),
           (333445555,20,10.0),
           (999887777,30,30.0);

           

INSERT INTO DEPENDENT
VALUES      (333445555,'Alice','F','1986-04-04','Daughter'),
            (333445555,'Theodore','M','1983-10-25','Son'),
            (333445555,'Joy','F','1958-05-03','Spouse'),
            (987654321,'Abner','M','1942-02-28','Spouse'),
            (123456789,'Michael','M','1988-01-04','Son'),
            (123456789,'Alice','F','1988-12-30','Daughter'),
            (123456789,'Elizabeth','F','1967-05-05','Spouse');

INSERT INTO DEPT_LOCATIONS
VALUES      (1,'Houston'),
            (4,'Stafford'),
            (5,'Bellaire'),
            (5,'Sugarland'),
            (5,'Houston');


select * from EMPLOYEE;
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary | Super_ssn | Dno |
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Houston,TX          | M    |  30000 |           |   5 |
| Franklin | T     | Wong    | 333445555 | 1965-12-08 | 638 Voss, Houston TX    | M    |  40000 | 888665555 |   5 |
| Joyce    | A     | English | 453453453 | 1972-07-31 | 5631 Rice, Houston TX   | F    |  25000 | 333445555 |   5 |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble TX | M    |  38000 | 333445555 |   5 |
| James    | E     | Borg    | 888665555 | 1937-11-10 | 450 Stone, Houston TX   | M    |  55000 | NULL      |   1 |
| Jennifer | S     | Wallace | 987654321 | 1941-06-20 | 291 Berry, Bellaire TX  | F    |  43000 | 888665555 |   4 |
| Ahmad    | V     | Jabbar  | 987987987 | 1969-03-29 | 980 Dallas, Houston TX  | M    |  25000 | 987654321 |   4 |
| Alicia   | J     | Zelaya  | 999887777 | 1968-01-19 | 3321 Castle, Spring TX  | F    |  25000 | 987654321 |   4 |
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+
8 rows in set (0.00 sec)


 select * from DEPARTMENT;
+----------------+---------+-----------+----------------+
| Dname          | Dnumber | Mgr_ssn   | Mgr_start_date |
+----------------+---------+-----------+----------------+
| Headquarters   |       1 | 888665555 | 1981-06-19     |
| Administration |       4 | 987654321 | 1995-01-01     |
| Research       |       5 | 333445555 | 1988-05-22     |
+----------------+---------+-----------+----------------+
3 rows in set (0.00 sec)


 select * from PROJECT;
+-----------------+---------+-----------+------+
| pname           | pnumber | plocation | dnum |
+-----------------+---------+-----------+------+
| ProductX        |       1 | Bellaire  |    5 |
| ProductY        |       2 | Sugarland |    5 |
| ProductZ        |       3 | Houston   |    5 |
| Computerization |      10 | Stafford  |    4 |
| Reorganization  |      20 | Houston   |    1 |
| Newbenefits     |      30 | Stafford  |    4 |
+-----------------+---------+-----------+------+
6 rows in set (0.00 sec)


 select * from DEPENDENT;
+-----------+----------------+------+------------+--------------+
| Essn      | Dependent_name | Sex  | Bdate      | Relationship |
+-----------+----------------+------+------------+--------------+
| 123456789 | Alice          | F    | 1988-12-30 | Daughter     |
| 123456789 | Elizabeth      | F    | 1967-05-05 | Spouse       |
| 123456789 | John           | M    | 1973-04-04 | Brother      |
| 123456789 | Michael        | M    | 1988-01-04 | Son          |
| 333445555 | Alice          | F    | 1986-04-04 | Daughter     |
| 333445555 | Joy            | F    | 1958-05-03 | Spouse       |
| 333445555 | Theodore       | M    | 1983-10-25 | Son          |
| 987654321 | Abner          | M    | 1942-02-28 | Spouse       |
+-----------+----------------+------+------------+--------------+
8 rows in set (0.00 sec)



 select * from WORKS_ON;
+-----------+-----+-------+
| Essn      | Pno | Hours |
+-----------+-----+-------+
| 123456789 |   1 |  32.5 |
| 123456789 |   2 |   7.5 |
| 333445555 |   2 |  10.0 |
| 333445555 |   3 |  10.0 |
| 333445555 |  10 |  10.0 |
| 333445555 |  20 |  10.0 |
| 453453453 |   1 |  20.0 |
| 453453453 |   2 |  20.0 |
| 666884444 |   3 |  40.0 |
| 999887777 |  30 |  30.0 |
+-----------+-----+-------+
10 rows in set (0.00 sec)




select * from DEPT_LOCATIONS;
+---------+-----------+
| Dnumber | Dlocation |
+---------+-----------+
|       1 | Houston   |
|       4 | Stafford  |
|       5 | Bellaire  |
|       5 | Houston   |
|       5 | Sugarland |
+---------+-----------+
5 rows in set (0.00 sec)




3a. Retrieve the name and address of all employees who work for the ‘Research’ department.

select Fname, Minit, Lname, Address 
    from EMPLOYEE e, DEPARTMENT d where
    e.Dno=d.Dnumber
    and
    d.Dname="Research";

+----------+-------+---------+-------------------------+
| Fname    | Minit | Lname   | Address                 |
+----------+-------+---------+-------------------------+
| John     | B     | Smith   | 731 Houston,TX          |
| Franklin | T     | Wong    | 638 Voss, Houston TX    |
| Joyce    | A     | English | 5631 Rice, Houston TX   |
| Ramesh   | K     | Narayan | 975 Fire Oak, Humble TX |
+----------+-------+---------+-------------------------+


3b. For every project located in ‘Stafford’, list the project number, the controlling department number, and the department manager’s last name, address, and birth date.

select e.Lname, e.Bdate, e.Address, p.pnumber, p.dnum
    from EMPLOYEE e, PROJECT p, DEPARTMENT d 
    where p.plocation="Stafford" and p.dnum=d.Dnumber
    and d.Mgr_ssn=e.Ssn;

+---------+------------+------------------------+---------+------+
| Lname   | Bdate      | Address                | pnumber | dnum |
+---------+------------+------------------------+---------+------+
| Wallace | 1941-06-20 | 291 Berry, Bellaire TX |      10 |    4 |
| Wallace | 1941-06-20 | 291 Berry, Bellaire TX |      30 |    4 |
+---------+------------+------------------------+---------+------+


3c. For each employee, retrieve the employee’s first and last name and the first and last name  
     of   his or her immediate supervisor.
    select e1.Fname, e1.Lname, e2.Fname as manager_Fname, e2.Lname as     
    manager_Lname
    from EMPLOYEE as e1, EMPLOYEE as e2 
    where e2.Ssn=e1.Super_ssn;

+----------+---------+---------------+---------------+
| Fname    | Lname   | manager_Fname | manager_Lname |
+----------+---------+---------------+---------------+
| Franklin | Wong    | James         | Borg          |
| Joyce    | English | Franklin      | Wong          |
| Ramesh   | Narayan | Franklin      | Wong          |
| Jennifer | Wallace | James         | Borg          |
| Ahmad    | Jabbar  | Jennifer      | Wallace       |
| Alicia   | Zelaya  | Jennifer      | Wallace       |
+----------+---------+---------------+---------------+
6 rows in set (0.00 sec)


3d. Make a list of all project numbers for projects that involve an employee whose last name is   
     ‘Smith’, either as a worker or as a manager of the department that controls the project.

(select distinct pnumber
From PROJECT,DEPARTMENT,EMPLOYEE
where Dnum=Dnumber AND Mgr_ssn=Ssn AND Lname="Smith")
UNION
(Select distinct pnumber
From PROJECT,WORKS_ON,EMPLOYEE
where pnumber=Pno AND Essn=Ssn AND Lname="Smith");


+---------+
| pnumber |
+---------+
|       1 |
|       2 |
+---------+
2 rows in set (0.00 sec)



3e. Retrieve all employees whose address is in Houston, Texas.

         select Fname, Minit, Lname 
    from EMPLOYEE 
    where Address like "%Houston%TX%"; 
  

+----------+-------+---------+
| Fname    | Minit | Lname   |
+----------+-------+---------+
| John     | B     | Smith   |
| Franklin | T     | Wong    |
| Joyce    | A     | English |
| James    | E     | Borg    |
| Ahmad    | V     | Jabbar  |
+----------+-------+---------+
5 rows in set (0.00 sec)




3f. Retrieve all employees in department 5 whose salary is between $30,000 and $40,000.

    select *
    from EMPLOYEE e, DEPARTMENT d 
    where e.Dno=d.Dnumber and d.Dnumber=5
    and e.Salary between 30000 and 40000;
 +----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+----------+---------+-----------+----------------+
| Fname    | Minit | Lname   | Ssn       | Bdate      | Address                 | Sex  | Salary | Super_ssn | Dno | Dname    | Dnumber | Mgr_ssn   | Mgr_start_date |
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+----------+---------+-----------+----------------+
| John     | B     | Smith   | 123456789 | 1965-01-09 | 731 Houston,TX          | M    |  30000 |           |   5 | Research |       5 | 333445555 | 1988-05-22     |
| Franklin | T     | Wong    | 333445555 | 1965-12-08 | 638 Voss, Houston TX    | M    |  40000 | 888665555 |   5 | Research |       5 | 333445555 | 1988-05-22     |
| Ramesh   | K     | Narayan | 666884444 | 1962-09-15 | 975 Fire Oak, Humble TX | M    |  38000 | 333445555 |   5 | Research |       5 | 333445555 | 1988-05-22     |
+----------+-------+---------+-----------+------------+-------------------------+------+--------+-----------+-----+----------+---------+-----------+----------------+
3 rows in set (0.00 sec)
   




4a. Retrieve the names of all employees who do not have supervisors.

         select Fname, Minit, Lname 
    from EMPLOYEE e 
    where 
    not exists(select * from EMPLOYEE as s where e.Super_ssn=s.Ssn);

+-------+-------+-------+
| Fname | Minit | Lname |
+-------+-------+-------+
| John  | B     | Smith |
| James | E     | Borg  |
+-------+-------+-------+
2 rows in set (0.00 sec)



4b. Retrieve the name of each employee who has a dependent with the same first name and is 
     the same gender as the employee
    select Fname, Minit, Lname 
    from EMPLOYEE e, DEPENDENT d where
    e.Fname=d.Dependent_name
    and 
    e.Sex=d.Sex;

+-------+-------+-------+
| Fname | Minit | Lname |
+-------+-------+-------+
| John  | B     | Smith |
+-------+-------+-------+
1 row in set (0.00 sec)



4c. Retrieve the names of employees who have no dependents.

         select Fname, Minit, Lname 
    from EMPLOYEE where 
    not exists(select * from DEPENDENT where Ssn=Essn);

+--------+-------+---------+
| Fname  | Minit | Lname   |
+--------+-------+---------+
| Joyce  | A     | English |
| Ramesh | K     | Narayan |
| James  | E     | Borg    |
| Ahmad  | V     | Jabbar  |
| Alicia | J     | Zelaya  |
+--------+-------+---------+
5 rows in set (0.00 sec)



4d. List the names of managers who have at least one dependent.

         select Fname, Minit, Lname 
    from EMPLOYEE where 
    exists(select * from DEPARTMENT where Ssn=Mgr_ssn and Dno=Dnumber)
    and
    exists(select * from DEPENDENT where Ssn=Essn);


+----------+-------+---------+
| Fname    | Minit | Lname   |
+----------+-------+---------+
| Franklin | T     | Wong    |
| Jennifer | S     | Wallace |
+----------+-------+---------+
2 rows in set (0.00 sec)



4e. Retrieve the Social Security numbers of all employees who work on project numbers 1, 2,  
     or 3.

         select distinct Essn from WORKS_ON where Pno in (1,2,3);

+-----------+
| Essn      |
+-----------+
| 123456789 |
| 453453453 |
| 333445555 |
| 666884444 |
+-----------+
4 rows in set (0.00 sec)




4f. Find the sum of the salaries of all employees of the ‘Research’ department, as well as the 
     maximum salary, the minimum salary, and the average salary in this department.
    select sum(Salary), max(Salary), min(Salary), avg(salary)
    from EMPLOYEE, DEPARTMENT 
    where Dno=Dnumber and Dname="Research";

+-------------+-------------+-------------+-------------+
| sum(Salary) | max(Salary) | min(Salary) | avg(salary) |
+-------------+-------------+-------------+-------------+
|      133000 |       40000 |       25000 |  33250.0000 |
+-------------+-------------+-------------+-------------+
1 row in set (0.00 sec)




4g. For each department, retrieve the department number, the number of employees in the 
     department, and their average salary.

         select Dno, count(*), avg(Salary)
    from EMPLOYEE 
    group by Dno;


+-----+----------+-------------+
| Dno | count(*) | avg(Salary) |
+-----+----------+-------------+
|   1 |        1 |  55000.0000 |
|   4 |        3 |  31000.0000 |
|   5 |        4 |  33250.0000 |
+-----+----------+-------------+
3 rows in set (0.00 sec)




























BANK DATABASE:

create table branch(
	branch_name varchar(25),
	branch_city varchar(25),
	assets int,
	primary key(branch_name));

create table account(
	accno int,
	branch_name varchar(25),
	balance int,
	primary key(accno));

create table customer(
	customer_name varchar(25),
	customer_street varchar(25),
	customer_city varchar(25),
	primary key(customer_name));
 
create table depositor(
	customer_name varchar(25),
	accno int,
	primary key(customer_name,accno),
	foreign key(customer_name) references customer(customer_name),
	foreign key(accno) references account(accno) on delete cascade);
  
create table loan(
	loan_number int,
	branch_name varchar(25),
	amount int,
	primary key(loan_number),
	foreign key(branch_name) references branch(branch_name));

insert into branch values('jaynagar','bangalore',15000000),
                         ('basavanagudi','bangalore',25000000),
                         ('noida','delhi',50000000),
                         ('marine drive','mumbai',40000000),
                         ('green park','delhi',30000000);

insert into account values(123,'jaynagar',25000);
insert into account values(156,'jaynagar',30000);
insert into account values(456,'basavanagudi',15000);
insert into account values(789,'noida',25000);
insert into account values(478,'marine drive',48000);
insert into account values(778,'green park',60000);
insert into account values(189,'basavanagudi',50000);

insert into customer values('ramu','jaynagar','bangalore');
insert into customer values('kumar','basavanagudi','bangalore');
insert into customer values('john','noida','delhi');
insert into customer values('mike','marine drive','mumbai');
insert into customer values('sachin','green park','delhi');
 
insert into depositor values('ramu',123);
insert into depositor values('ramu',156);
insert into depositor values('ramu',189);
insert into depositor values('kumar',456);
insert into depositor values('john',789);
insert into depositor values('mike','478');
insert into depositor values('sachin','778');

insert into loan values(1111,'jaynagar',250000);
insert into loan values(2222,'basavanagudi',350000);
insert into loan values(3333,'noida',150000);
insert into loan values(4444,'marine drive',1500000);
insert into loan values(5555,'green park',7500000);




mysql> select * from branch;
+--------------+-------------+----------+
| branch_name  | branch_city | assets   |
+--------------+-------------+----------+
| basavanagudi | bangalore   | 25000000 |
| green park   | delhi       | 30000000 |
| jaynagar     | bangalore   | 15000000 |
| marine drive | mumbai      | 40000000 |
| noida        | delhi       | 50000000 |
+--------------+-------------+----------+
5 rows in set (0.00 sec)

mysql> select * from account;
+-------+--------------+---------+
| accno | branch_name  | balance |
+-------+--------------+---------+
|   123 | jaynagar     |   25000 |
|   156 | jaynagar     |   30000 |
|   189 | basavanagudi |   50000 |
|   456 | basavanagudi |   15000 |
|   478 | marine drive |   48000 |
|   778 | green park   |   60000 |
|   789 | noida        |   25000 |
+-------+--------------+---------+
7 rows in set (0.00 sec)

mysql> select * from depositor;
+---------------+-------+
| customer_name | accno |
+---------------+-------+
| ramu          |   123 |
| ramu          |   156 |
| ramu          |   189 |
| kumar         |   456 |
| mike          |   478 |
| sachin        |   778 |
| john          |   789 |
+---------------+-------+
7 rows in set (0.00 sec)

mysql> select * from customer;
+---------------+-----------------+---------------+
| customer_name | customer_street | customer_city |
+---------------+-----------------+---------------+
| john          | noida           | delhi         |
| kumar         | basavanagudi    | bangalore     |
| mike          | marine drive    | mumbai        |
| ramu          | jaynagar        | bangalore     |
| sachin        | green park      | delhi         |
+---------------+-----------------+---------------+
5 rows in set (0.00 sec)

mysql> select * from loan;
+-------------+--------------+---------+
| loan_number | branch_name  | amount  |
+-------------+--------------+---------+
|        1111 | jaynagar     |  250000 |
|        2222 | basavanagudi |  350000 |
|        3333 | noida        |  150000 |
|        4444 | marine drive | 1500000 |
|        5555 | green park   | 7500000 |
+-------------+--------------+---------+
5 rows in set (0.00 sec)




5a. Find all the customers who have atleast two accounts at the main branch

select distinct(customer_name), count(*) 
from account a, depositor d 
where  a.accno=d.accno and 
 d.accno in (select accno from account where branch_name='jaynagar') 
group by d.customer_name having count(*)>=2;








+---------------+----------+
| customer_name | count(*) |
+---------------+----------+
| ramu          |        2 |
+---------------+----------+
1 row in set (0.00 sec)



5b. Find all the customers who have an account at all the branches located in a specified city.

select d.customer_name from 
account a, depositor d, branch b where 
b.branch_name=a.branch_name 
and 
a.accno=d.accno 
and 
b.branch_city='bangalore' 
group by customer_name having 
count(distinct b.branch_name) = (select count(branch_name) from branch where branch_city='bangalore');

or

5b. Find all the customers who have an account at all the branches located in a specified city

SELECT d.customer_name
FROM account a
JOIN depositor d ON a.accno = d.accno
JOIN branch b ON a.branch_name = b.branch_name
WHERE b.branch_city = 'bangalore'
GROUP BY d.customer_name
HAVING COUNT(DISTINCT b.branch_name) = (SELECT COUNT(branch_name) FROM branch WHERE branch_city = 'bangalore');


+---------------+
| customer_name |
+---------------+
| ramu          |
+---------------+
1 row in set (0.00 sec)




5c. Demonstrate how you delete all account tuples at every branch located in a specified city

delete from account 
where branch_name 
in (select branch_name from branch where branch_city='delhi' and accno <> 0);

after executing the delete query output will "delete from account Query OK, 2 rows affected (0.03 sec)"


Before deletion account table

 select * from branch;
+--------------+-------------+----------+
| branch_name  | branch_city | assets   |
+--------------+-------------+----------+
| basavanagudi | bangalore   | 25000000 |
| green park   | delhi       | 30000000 |
| jaynagar     | bangalore   | 15000000 |
| marine drive | mumbai      | 40000000 |
| noida        | delhi       | 50000000 |
+--------------+-------------+----------+
5 rows in set (0.00 sec)

select * from account;                          

+-------+--------------+---------+     
| accno | branch_name  | balance |
+-------+--------------+---------+
|   123 | jaynagar     |   25000 |
|   156 | jaynagar     |   30000 |
|   189 | basavanagudi |   50000 |
|   333 | basavanagudi |   25000 |
|   456 | basavanagudi |   15000 |
|   478 | marine drive |   48000 |
|   778 | green park   |   60000 |
|   789 | noida        |   25000 |
+-------+--------------+---------+
8 rows in set (0.00 sec)


After deletion account table
 
select * from account;
+-------+--------------+---------+
| accno | branch_name  | balance |
+-------+--------------+---------+
|   123 | jaynagar     |   25000 |
|   156 | jaynagar     |   30000 |
|   189 | basavanagudi |   50000 |
|   333 | basavanagudi |   25000 |
|   456 | basavanagudi |   15000 |
|   478 | marine drive |   48000 |
+-------+--------------+---------+
6 rows in set (0.00 sec)
 




