**free

dcl-pr ifsOpenFile  pointer extProc( '_C_IFS_fopen' );  // Opens/Creates a file pointer
  *n pointer value options(*string);                    // File Name
  *n pointer value options(*string);                    // Access Mode String
end-pr;
