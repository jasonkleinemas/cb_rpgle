**FREE

/copy ../cb_rpgle/generalSystemOs/executeCommand.rpgle

/if Not Defined(sendMessage)
/define sendMessage

dcl-proc sendMessage;
  dcl-pi *n       char(7);
    is_message    char(200) value;
    is_user       char(1) value;
  end-pi;
  
  dcl-s err  char(7);
  
  err = executeCommand('SNDMSG MSG(''' + %trim(is_message) + ''') TOUSR(''' + %trim(is_user) + ''')' );
  
  return err;

end-proc;
/endIf