//Procedure prototype
dcl-pr Proc1 ind;
    Parm1 char(5);
    Parm2 char(10) const options(*nopass);
end-pr;
//PI
dcl-proc Proc1 export;
    dcl-pi proc ind ;
    Parm1 char(5);
    Parm2 char(10) const options(*nopass);
    end-pi;
  if %parms() = 1;
   //one paramerter
  endif;
  return ind;
end-proc;
//
Options(*Varsize) // to pass char(5) to parm having char(10)
Options(*omit)     // to use proce(parm1:*omit);
options(*nopass:*omit)
//pass by value
dcl-pr proc1 char(8);
 parm1 char(5) value; //pass by value sends a copy , value wont change in calling program
end-pr;
//use of const
dcl-pr proc1;
    parm1 varchar(1000) const; // value passed as constant value proc1(actualvalue), also variable of char(100) or varchar(100) can be passed.
end-pr;
