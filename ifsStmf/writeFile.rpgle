**free

dcl-pr ifsWriteFile int(10:0) extProc('_C_IFS_fputs');  // Puts Data to File
  *n pointer value  options( *string );                 // String to Write
  *n pointer value;                                     // File pointer from open
end-pr;

