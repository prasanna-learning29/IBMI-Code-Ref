TO_CHAR(date,'YYYY-MM-DD');
LOCATE_IN_STRING(search_variable,'K',1); // returns the first position where K is present in search_variable
Select from table Offset 10 rows; // skips first 10 records in the result set
select from table fetch first 1 rows only; // fetches 1 row only
Colesce(field,0) //returns field if not null else returns 0
Cast(field as Decimal(5,0)) //converts field to decimal data type
case when field = 'ABC' then 'Char' else 'Num' end // sample case statement
Alter table set column not null as default//
ADD_DAYS(CURRENT_DATE, 1) // add days to date field
Translate(String,'^','0123456789') // converts numbers to ^
Listagg(Name,',') // makes name from rows into single string using group by
--To create dummy tables use 
    select 'Value1' from sysibm.sysdummy2;
