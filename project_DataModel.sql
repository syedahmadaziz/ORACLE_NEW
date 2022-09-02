Create Table Department(Deptid number(10),DeptName varchar(40),constraint pk_deptid primary key(Deptid));

desc department;

Create Table Employee (EmpId Number(10),EmpName varchar2(30),
                       Gender char(1),
                       MobileNumber Number(10),
                       Email varchar2(40),
                       Address varchar2(100),
                       Salary number(10,2),
                       DOJ Date,
                       Deptid Number(10),
                       Bandid Number(10),
                       constraint pk_empid primary key(EmpId),
                       constraint fk_deptid foreign key(Deptid) references Department(Deptid),
                       constraint fk_bandid foreign key(Bandid) references Band(Bandid));
                       
desc employee;