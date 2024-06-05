**Free
/if not Defined(executeCommand)
/define executeCommand

  dcl-proc executeCommand;
    dcl-pi *n     char(   7);
      ps_text  varchar(1000) const;
    end-pi;

/copy ../generalSystemOsApi/QCMDEXC.executeCommand.rpgle

    dcl-s wi_cmdLen packed(15:5) inz(0);

    wi_cmdLen = %len(ps_text);

    QCMDEXC(ps_text:wi_cmdLen);

    return *blank;

  end-proc;
/endif
