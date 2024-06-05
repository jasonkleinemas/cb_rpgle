**Free
/if not defined(dsApiError0100)
/define dsApiError0100
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
  dcl-ds dsApiError0100 inz qualified template;
    bytesProvided  int(10:0) inz(%size(dsApiError0100)); // Not sure if this should be inz
    bytesAvailable int(10:0) inz(0);
    exceptionID    char(7)   inz('');
    reserved       char(1)   inz(x'00');
    exceptionData  char(256) inz(''); // 3000
  end-ds;

/endif

