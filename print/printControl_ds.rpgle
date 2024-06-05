**Free

//
// On file declare dcl-f prtctl(qsysprtCtl)
//
  dcl-ds qsysprtCtl len(15) qualified inz;
    sp_b4  char(3); // Space Line before 0-255
    sp_aft char(3); // Space Line After 0-255
    sk_b4  char(3); // Skip to line number 0-255
    sk_aft char(3); // Skip to line number 0-255
    ocln   zoned(3:0); // Current Line number
  end-ds;
