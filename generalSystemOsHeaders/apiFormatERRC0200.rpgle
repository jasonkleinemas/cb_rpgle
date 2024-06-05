**Free
//========================================================================
// IBM API Error Code parameter -- ERRC0100 format
//
// NOTE: If supported, including this data structure as a parameter in your
// API calls is equivalent to using MONITOR to trap hard errors.  If
//   an error occurs, it allows the API to pass back the error message
//   id and any replacement data associated with that message id.
//
// DOCUMENTATION:
//  https://www.ibm.com/docs/en/i/7.5?topic=parameter-error-code-format
//
  dcl-ds dsApiError0200 inz qualified template;
    key            int(10:0) inz;
    bytesProvided  int(10:0) inz(%size(dsApiError0200));
    bytesAvailable int(10:0) inz;
    exceptionID    char(7)   inz;
    reserved       char(1)   inz(x'00');
    CCSIDofCCHAR   int(10:0) inz;
    Offset         int(10:0) inz;
    Length         int(10:0) inz;
    Exception data char(256) inz; // Varable length
  end-ds;

