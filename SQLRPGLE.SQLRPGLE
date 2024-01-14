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

//Using sensitive cursor will include added records aswell as updated records after the cursor is delcared and opened. Normal static cursor will not include latest changes
Declare c1 sensitive dynamic scroll cursor for 
	select stmt;
//To write data to ifs using qsys2/ifs_write

CALL QSYS2/IFS_WRITE
     (PATH_NAME => 'IFS Path with directory and File Name', //'Home/user/Filename.txt'
      LINE => 'Data to be written',							//'Hello_world'
      FILE_CCSID => CCSID(Integer),							//ccisd 
      OVERWRITE => 'Overwrite Option',						//Append or Replace or None
      END_OF_LINE => 'End of Line Option')					//attach CRLF, LF,CR to end of record

//To read data from ifs using Qsys2.ifs_read
dcl-s line Char(32740) inz;
dcl-s filecontent char(3240) inz;
Query = 'Select cast(line as char(32740)) as line from table(qsys2.Ifs_read('/home/user/file.txt'))';
// Line will present as pointer so we are using cast function to convert it to character
prepare p1 from :query;
Declare C1 for P1;
open c1;
fetch next from c1 into :line;
dow sqlcode = 0;
	filecontent = %trim(filecontent) + ' ' + %trim(line);
	fetch next from c1 into :line;
enddo;
close c;
this will have LF/CR/null to remove
filecontent = %xlate(X'00250D'F:'   ':fileconent);

//To check if the ifs object is present in Path
select count(1) into :indicator
	from table(IFS_OBJECT_STATISTICS(START_PATH_NAME = '/home/user/file.txt'));
// we can use these to list of objects present in ifs directory as well.

//to call cl commands
call qsys2/qcmdexC('createfile');

//convert splf to pdf in ifs using sql

VALUES SYSTOOLS.GENERATE_PDF('9999999/QUSER/MYJOBNAME','QSYSPRT',9,
                             '/home/SIMON/file.pdf') ;
//data queues in sql
DATA_QUEUE_INFO
CLEAR_DATA_QUEUE
SEND_DATA_QUEUE
RECEIVE_DATA_QUEUE table function
//

SELECT CURRENT_MESSAGES
  FROM QSYS2.DATA_QUEUE_INFO
 WHERE DATA_QUEUE_LIBRARY = 'MYLIB'
   AND DATA_QUEUE_NAME = 'TESTDTAQ' // to check current-messages in DATA_QUEUE_INFO
//
exec sql CALL QSYS2.CLEAR_DATA_QUEUE('TESTDTAQ','MYLIB') ;
exec sql CALL QSYS2.SEND_DATA_QUEUE(:Snd.QData,
                                          'TESTDTAQ',
                                          'MYLIB') ; //snd.qdata is char
//
 exec sql SELECT MESSAGE_DATA INTO :Rcved.Data
                 FROM TABLE(QSYS2.RECEIVE_DATA_QUEUE(
                            DATA_QUEUE => 'TESTDTAQ',
                            DATA_QUEUE_LIBRARY => 'MYLIB',
                            REMOVE => 'YES',
                            WAIT_TIME => 5)) ; //rcved.data is char 
//Search strings in sql

