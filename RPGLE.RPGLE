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
