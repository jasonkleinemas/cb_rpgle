**Free
/if not defined(sendUserMessage_p)
/define sendUserMessage_p
//
// Requires:
// /copy ../cb_rpgle/generalSystemOsHeaders/apiFormatERRC0100.rpgle
//

  dcl-proc sendUserMessage;
    dcl-pi *n;
      is_user    varchar(10 ) const;
      is_message varchar(500) const;
    end-pi;

    dcl-ds myApiError likeds(dsApiError0100);
    dcl-s wi_functionRequesed int(10) inz(0);
    dcl-s wi_messageSentInd   int(10) inz(1);

/copy ../generalSystemOsApi/QEZSNDMG.sendMessage.rpgle
    
    QEZSNDMG(
      '*INFO':
      '*NORMAL':
      %trim(is_message):
      %len(is_message):
      %upper(%trim(is_user)):
      1:
      wi_messageSentInd:
      wi_functionRequesed:
      myApiError:
      'N':'':'*USR'
    );
    
    dsply (myApiError.exceptionID);
    
  end-proc;

/endif
