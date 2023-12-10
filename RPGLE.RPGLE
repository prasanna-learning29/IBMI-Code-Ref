//to check lock status of file
if %status(file) = 01218;
    //file is locked
endif;
//to check lock status of particula record
chain(e) key1 file;
    if %error and %status(file) = 01218;
        file is  locked
    endif;
//reading flat file in rpgle
dcl-f file usage(*input) rename(Filefmt) prefix(F1) ;
    setll *start file;
    reade file;
        dow not %eof();
            //
         reade file;
        enddo;
//chain
CHAIN (Search Arguments/Key Fields) FILENAME ;
IF %FOUND(FILENAME) ; 
// Required Program Logic
ENDIF ;
//Setll reade
SETLL (Search Arguments/Key Fields) FILENAME ; 
READE (Search Arguments/Key Fields) FILENAME ;
DOW NOT %EOF(FILENAME) ;
// Required Program Logic
READE (Search Arguments/Key Fields) FILENAME ;
ENDDO
//to check if the data is present without having to read the record
SETLL (Search Arguments/Key Fields) FILENAME ; 
IF %FOUND(FILENAME) ;
// Required Program Logic
ENDIF ;
//Reading xml file in rpgle
xml-into Person %xml('/SAMPLE/test.xml':
                         'case=any doc=file') ; // person is datastructure with subfields as xml elements