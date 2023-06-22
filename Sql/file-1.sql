

---Syntax

Declare

[Variable declaration];

Begin

      <executable statements>;

      Exception when <Exception name> then

          <executable statements>;

End;

---Ø A simple PL/SQL Program for sum of two numbers

Declare

Fnum number;

Snum number;

Total number;

Begin

Fnum:= :fn;

Snum:= :sn;

Total:= Fnum+Snum;

Dbms_output.put_line(‘The sum of two numbers is : ’||Total);

End;

---Ø Write PL/SQL program to display ename, sal, comm, net salary for entered employee number?

Declare

Vempno number(4):=:p_empno;

Vename varchar2(100);

Vsal number(7,2);

Vcomm number(7,2);

Netsal number(7,2);

Begin

Select ename,sal,comm into Vename,Vsal,Vcomm from emp where empno=Vempno;

Netsal:=Vsal+NVL(Vcomm,0);

Dbms_output.put_line(‘The Employee details are ’||Vename||’ ‘||Vsal||’ ‘||Vcomm||’ ‘||Netsal);

End;

/*Ø To save the program in SQL * Plus

Save <drive name>:\<folder nam>\<file name>

Ex: - Save e:\plsql\p1

Ø To run the script in SQL * plus

@ d:\plsql\p1

Ø To edit file in SQL * Plus

Ed d:\plsql\p1

Ø To get the source code in SQL * Plus

Get d:\plsql\p1

Ø To RUN and Get the script in SQL * Plus

Run d:\plsql\p1

Ø Some Banking business rules examples

Create unique and not null account no

1 we create one sequence st

Create sequence s1;

Then create account no as bellow

select 'KCB'||101||to_char(sysdate,'DD MM YY')||LPAD(s1.nextval,5,'0') from dual;

so account no be like

KCB10117062100001

KCB10117062100002

KCB10117062100003

Create account type

Acctype char

S- savings account (it has min bal 5000, withdraw only 30000 per day)

C- current account (it has min bal 10000, perform n no of transaction per day)

R- Recurring account (it has min bal 5000, he can take loan upto 70% after 2 years he

deposited amount)

*/

Create KCB_ACC_TAB table

create table KCB_ACC_TAB

(ACCNO varchar2(50) constraint pk_ano PRIMARY KEY,

Name varchar2(30) constraint nn_name NOT NULL,

ACCTYPE char constraint chk_at CHECK (ACCTYPE in('S','C','R')),

DOO TIMESTAMP DEFAULT SYSDATE,

Bal number (7,2) constraint nn_bal NOT NULL,

Constraint chk_bal_at CHECK ((ACCTYPE='S' AND BAL>=5000) OR (ACCTYPE='C' AND

BAL>=10000) OR (ACCTYPE='R' AND BAL>=5000)));

Insert values into KCB_ACC_TAB table

insert into KCB_ACC_TAB values('KCB'||101||to_char(sysdate,'DD MM YY') ||

LPAD(s1.nextval,5,'0'),'&NAME','&ACCTYPE','&DOO','&BAL');

Creating banking transaction table

create table KCB_TRAN2_TAB  (TID number constraint pk_tid PRIMARY KEY,

ACCNO varchar2(30) constraint fk_acno references KCB_ACC_TAB(ACCNO),

TTYPE char constraint chk_type check(TTYPE in('D','W')),

DOT timestamp default sysdate,

AMT number (8,2) constraint chk_amt check (AMT>100));

---Ø Wirte PL/SQL program to display name,exp,bal&acctype for entered account no (exp should in

years)?

Declare

Vname varchar2(30);

Vacctype char;

Vbal number(7,2);

Vdoo timestamp;

Exp number;

Begin

Select NAME,ACCTYPE,DOO,BAL into Vname,Vacctype,Vdoo,Vbal from KCB_ACC_TAB where

ACCNO=:p_accno;

Exp:=ROUND(MONTHS_BETWEEN(sysdate,Vdoo)/12);

Dbms_output.put_line(‘The account holder details are ‘||Vname||’ ‘||Vacctype||’ ‘||Vdoo||’ ‘||Vbal||’

‘||Exp);

End;

---Ø Nested blocks: -The block which is inside of another block is called nested block.

Forward reference is possible but backward reference is not possible.

Syntax

Declare

Begin

   Declare

   Begin

   End;

End;

---Example

Declare

M number:=100;

Begin

M:=200;

    Declare

    N number:=300;

    Total number;

    Begin

    M:=500;

    Total:=M+N;

    Dbms_output.put_line (‘The sum of M,N is ‘||Total);

    End;

Dbms_output.put_line (‘The value of M ‘||M);

End;

Output is

The sum of M,N is 800

The value of M is 300 (because it passes only forward declaration means last declaration

value for variable)

Ø Small procedure

Create or replace procedure display (V varchar2)

Is

Begin

Dbms_output.put_line (V);

End;

Execute this procedure in two ways

1. EXEC display(‘My name is kamal’);

2. Begin

Display(‘My name is kamal’);

End;

               Note: - from now onwards we use ‘display’ keyword instead of ‘Dbms_output.put_line’

keyword.

Ø How to convert anonymous block to label block

We need to place label before declare keyword. It can also appear after end keyword.

Advantage of label block is we can access the outer block variables in the inner block.

The label should be represented with in the double angled brackets like “<<block>>”.

Example

<<block1>>declare

M number:=100;

N number:=400;

Begin

M:=200;

       <<block2>>declare

       N number:=300;

       Total number;

       Begin

       M:=500;

       N:=700;

       Total:=M+block1.N;

       Display(‘The sum of M,N is ’||Total);

       Display(‘The value of inner block N is ‘||N);

       End block2;

Display(‘The value of M is ‘||M);

Display(‘The value of N is ‘||N);

End block1;

Output  is

The sum of M,N is 900

The value of inner block N is 700

The value of M is 500

The value of N is 400

Ø Write PL/SQL program to deposit amount , withdraw amount and enter that values into

KCB_TRAN2_TAB table and update KCB_ACC_TAB table?

Declare

Vaccno KCB_ACC_TAB.ACCNO%type:=:accno;

Vttype KCB_TRAN2_TAB.TTYPE%type:=:ttype;

Vamt KCB_TRAN2_TAB.AMT%type:=:amt;

Cbal KCB_ACC_TAB.BAL%type;

Begin

Select bal into Cbal from KCB_ACC_TAB where ACCNO=Vaccno;

if Vttype='D' then

Cbal:=Cbal+Vamt;

Update KCB_ACC_TAB set BAL=Cbal where ACCNO=Vaccno;

Insert into KCB_TRAN2_TAB values (nvl((select max(TID) from

KCB_TRAN2_TAB),100)+1,Vaccno,Vttype,sysdate,Vamt);

elsif Vttype='W' then

Cbal:=Cbal-Vamt;

Update KCB_ACC_TAB set BAL=Cbal where ACCNO=Vaccno;

Insert into KCB_TRAN2_TAB values (nvl((select max(TID) from

KCB_TRAN2_TAB),100)+1,Vaccno,Vttype,sysdate,Vamt);

Commit;

end if;

End;

Ø Write PL/SQL program to display Name, total marks, avg marks, highest marks, lowest marks

for entered roll no?

1 create student table

Create table student(Rollno number, Sname varchar2(20), Sclass varchar2(20), S1 number, S2

number, S3 number, S4 number, S5 number);

Insert into student values(1,’Kamal’,’CSE’,100,95,98,78,89);

Insert into student values(2,’Raj’,’IT’,77,91,69,66,88);

Declare

i student%rowtype;

Vtm number;

Vavg number;

Vhm number;

Vlm number;

Begin

st

PLSQL Class 13 in Telugu | Sub programs in plsql| Triggers in

PL/SQL on ...

PLSQL CURSOR

To leave a comment, click the button below to sign in with Google.

SIGN IN WITH GOOGLE

Popular posts from this blog

- March 14, 2022

- September 01, 2021

Select Sname,S1,S2,S3,S4,S5 into i.Sname, i.S1, i.S2, i.S3, i.S4, i.S5 from student where

Rollno=:p_rollno;

Vtm:=i.S1+i.S2+i.S3+i.S4+i.S5;

Vavg:=Vtm/5;

Select greatest(i.S1, i.S1, i.S3, i.S4, i.S5), least(i.S1, i.S1, i.S3, i.S4, i.S5) into Vhm,Vlm from dual;

Display(‘The student details are ’||i.Sname||’ ‘||Vtm||’ ‘||Vavg||’ ‘||Vhm||’ ‘||Vlm);

End;

Banking Table creation Labeled block Nested Block

PL/SQL Class Notes 1-> Introduction PLSQL Block structure PLSQL Variables

READ MORE

Archive

Hi friends i am sharing simple sql

material prepared by me . if any one

need these classes in telugu please

watch my channel "Kamal SQL CLASSES

in Telugu" and subscribe my channel

VISIT PROFILE

PLSQL Class 10 in Telugu | Sub programs in plsql| Procedures in

plsql

- October 28, 2021

 Powered by Blogger

Theme images by badins

  CURSOR à In order to process SQL statements oracle will allocate an area of memory known

as context area. PL/SQL uses it to store and execute SQL statements. The information

retrieved from database which is available in context area is known as active set. A CURSOR is…

READ MORE

READ MORE

Labels

Report Abuse
