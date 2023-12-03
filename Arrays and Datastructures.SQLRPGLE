Datastructures:
qualified DS
if we mention qualified we have refer to ds by Dsname.field
**************
Likeds is used to refer physical fields in program
***********
overlay
Overlay is used take values to array from datastructure.
DNum_ds1          DS                                          
DNum1                            3S 0                         
DNum2                            3S 0                         
dnum                             3S 0 DIM(2) Overlay(Num_ds1) 
*****************8

Mulitple Dimension
mulitple occurence of datastructure -- array of datastrutucre
DNum_ds2          DS                  qualified Dim(2)     
DNum1                            3S 0                      
DNum2                            3S 0          

*******************            
INFDS( Information file
*********************************************************
PSDS( Program status Data structure)
PSDS      SDS
IBM supplied predefined datastruture , we can program status , Number of parameter passed , Program name , Module name , job name , user, date , time from this datastructure
*********************************************************

EXTfile ds
*********************************************************
Data area DS
Daara     UDS
Dvar1     1   10
Dvar2     1   11

We can use In LDA and update the values and issue OUT LDA to update in dtaara which can be read by other programs


***********************************************************
Arrays:

//Runtime array - values are loaded when the program is called its dynamic
Sorta ( array);   - to sort the array
%Lookup ( 152 : array)  -- it will search 152 in array and return the positon of the array where it is prest

How to sort in descending order
Num_array        S              3S 0 DIM(3)  Descend 
Sorta ( num_array)

Dledgers	S	26 0 DIM(9999)
%Lookup(variable:Ledgers)
SOrta- sorts the elements in ascending order
sorta %subarr(ledgers:1:25);

%subarr( num_array : 4 : 4) --- it can be copied new array from num_array(4) to num_array(8)

sorting array datastructure
DCL-DS families QUALIFIED DIM(10);
   name VARCHAR(25);
   num_children INT(10);
END-DS;


pos = %LOOKUP('Smith' : families(*).name);

Complile time array:
In complie time array values are loaded in the program itself:
Dcmp_array        S              3S 0 DIM(9)  ctdata perrcd(2)
**CTDATA cmp_array 
123456             
789101             
102103             

Here perrcd means for one record two values 123 will be in cmp_array(1) and 456 will be in cmp_array(2)