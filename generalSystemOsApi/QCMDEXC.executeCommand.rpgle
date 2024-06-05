**Free
/if not defined(QCMDEXC_executeCommand)
/define QCMDEXC_executeCommand

  dcl-pr QCMDEXC extpgm;
    *n     char(1000) const; // Command Text
    *n   packed(15:5) const; // Command Length
  end-pr;
  
/endif
