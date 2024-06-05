**FREE
//
// This is way to complex.
//
/if not defined(QEZSNDMG_sendMessage)
/define QEZSNDMG_sendMessage

  dcl-pr QEZSNDMG extPgm('QEZSNDMG'); // Send Message (QEZSNDMG)
    *n                      
    *n          like(dsApiError0100); // Error code
  end-pr;
  
/endIf

