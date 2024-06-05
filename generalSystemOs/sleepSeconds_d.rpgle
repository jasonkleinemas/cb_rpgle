**Free
/if not defined(sleep_d)
/define sleep_d

  dcl-pr sleep extproc('sleep');                               
    *n uns(10) value; // Seconds
  end-pr;
  
/endif
