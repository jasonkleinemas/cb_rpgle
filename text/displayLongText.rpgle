**Free
/if not defined(displayLongText_p)
/define displayLongText_p
//
// Requires:
// /copy ../cb_rpgle/generalSystemOsHeaders/apiFormatERRC0100.rpgle
//

  dcl-proc displayLongText;
    dcl-pi *n;
      p_text    varchar(8192) const;
      p_msgId   char(7)       options(*nopass:*omit);
      p_msgFile char(21)      options(*nopass:*omit);
    end-pi;

/copy ../cb_rpgle/generalSystemOsApi/QUILNGTX.displayLongText.rpgle

    dcl-ds myApiError likeds(dsApiError0100);

    dcl-s msgId   like(p_msgId);
    dcl-s msgFile like(p_msgFile);

    if %parms = 1;
      msgId   = 'CAE0103'; // 'Press Enter to continue.'
      msgFile = 'QCPFMSG   *LIBL';
    elseif %parms = 2;
      msgId   = p_msgId;
      msgFile = 'QCPFMSG   *LIBL';
    elseif %parms = 3;
      msgId   = p_msgId;
      msgFile = p_msgFile;
    endif;

    QUILNGTX (
      p_text : %len(p_text) :
      msgId  : msgFile      :
      myApiError
    );

  end-proc;

/endif
