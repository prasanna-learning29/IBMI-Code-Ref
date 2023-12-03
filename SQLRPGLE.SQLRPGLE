// structure for updating database records using Cursor

dcl-ds File qualified extname('File') inz end-ds;
exec sql Declare c1 cursor for 
		select * from file where field = :HV
		for update of Field1, Field2;
exec sql open c1
exec sql fetch from c1 into :File;
dow sqlcode = 0;
//do validation or update
	file.field1 = 'Changed';
	exec sql Update File
			 set field1 = :file.Field1
			 where current of c1;
enddo;
close c1;

//structure to insert a record into File

dcl-ds File qualified extname('File') inz end-ds;
file.f1 = 'ABC';
file.F2 = 'DEF';
exec sql insert into file (f1,f2)
		 values (:file.f1,:file.f2);

//sturture to read a file

dcl-ds File qualified extname('File') inz end-ds;

exec sql 
declare c1 cursor for select F1,F2 from file where F3 = :HV;
exec sql open c1;
exec sql fetch from c1 into :F1,:f2;
dow sqlcode = 0;
	fetch next from c1 into :f1,:F2;
enddo;

//Prepare and execute examples

	sqlquery = 'select..' + %trim(file) ;
	exec sql prepare p1 from :sqlquery;
	exec sql declare c1 cursor for P1 ;
	exec sql  execute p1;
	sqlquery = 'select from file where field = ?';
	exec sql prepare P1 from :sqlquery;
	exec sql executre p1 using :hv;
	
//select 

exec sql select F1 into :F1 from file where f2 = :f2
		fetch first row only;
	// select , into will go into error if it returns multple error.

// how to get multiple rows

dcl-dS Fds qualified dim(99) inz;
f1 like(f1);
f2 like(f2);
end-ds;
dcl-c sqlrows const(99);
exec sql declare c1 for select F1,f2 from file where F3 = 99 rows;
exec sql open c1;
exec sql fetch c1 for :sqlrows into :fds;
exec sql close c1;

// declaring cursor using host variable

String = 'SELECT * FROM TESTFILE WHERE ACCTNBR > ? +
                 AND ACCTSTATE = ?' ;
exec sql PREPARE S0 FROM :String ;
exec sql DECLARE C0 CURSOR FOR S0 ;
exec sql OPEN C0 USING :wkAccount,:wkState ;
exec sql FETCH C0 INTO :InputDs ;
exec sql CLOSE C0 ;

// execute immediate  combines prepare and execute

sqlquery = 'insert...';
exec sql execute immediate :sqlquery;

//scroll Cursor

exec sql declare scroll c1 for select ;
exec sql open c1;
exec sql fetch scroll-option from C1 into :ds
//Fetch Scroll-option from C into :ds
//--Scroll- options : Next, First, Last, prior, before(places cursor before first row),after(places cursor after last row),current, Relative +5 , Relative +var ,n-var