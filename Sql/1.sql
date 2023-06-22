--- Ø A simple PL/SQL Program for sum of two numbers
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

---Ø Wirte PL/SQL program to display name,exp,bal&acctype for entered account no (exp should in years)?
Declare
    Vname varchar2(30);
    Vacctype char;
    Vbal number(7,2);
    Vdoo timestamp;
    Exp number;
Begin
    Select NAME,ACCTYPE,DOO,BAL into Vname,Vacctype,Vdoo,Vbal from KCB_ACC_TAB where ACCNO=:p_accno;
    Exp:=ROUND(MONTHS_BETWEEN(sysdate,Vdoo)/12);
    Dbms_output.put_line(‘The account holder details are ‘||Vname||’ ‘||Vacctype||’ ‘||Vdoo||’ ‘||Vbal||’
    ‘||Exp);
End;

--- Nested Block ex
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


---DCL
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
        KCB_8TRAN2_TAB),100)+1,Vaccno,Vttype,sysdate,Vamt);
        Commit;
    end if;
End;



