//Declaration for pointers
**Free
/Include qcpysrc/TemplateDS //have the ds declared as qualified and refer it in both pgms
//PGM A
dcl-ds DS1 Likeds(TemplateDS) Inz;
dcl-s Pointer@ pointer inz;

pointer@ = %alloc(%size(DS1));

Dealloc(NE) pointer@;

//PGM B
dcl-ds DS2 likeds(TemplateDS) based(pointer@);

//DS2




