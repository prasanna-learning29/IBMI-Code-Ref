//Declaration for pointers
**Free
/Include qcpysrc/TemplateDS //have the ds declared as qualified and refer it in both pgms
//PGM A
dcl-ds DS1 Likeds(TemplateDS) based(pointer@);
dcl-s Pointer@ pointer inz;

pointer@ = %alloc(%size(DS1));
PgmB(pointer@)
Dealloc(NE) pointer@;

//PGM B
dcl-ds DS2 likeds(TemplateDS) based(pi_pointer@);

//DS2 is taken from Pgm a from DS1



