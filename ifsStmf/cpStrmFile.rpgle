**Free
/if not Defined(copyStreamFile)
/define copyStreamFile
//
// Parm 1 Full IFS path /dir/fullFilename
//
// Parm 2 /QSYS.LIB/toLib.LIB/toFile.FILE/toMember.MBR
//
// Parm 3 Optional *NONE *ADD *REPLACE Default *NONE
//
    dcl-proc copyStreamFileToPF;
    dcl-pi copyStreamFileToPF;
      ps_streamFile   varchar(256) const;
      ps_member       varchar(256) const;
      ps_memberOption varchar(8)   const options(*nopass:*omit);
    end-pi;

    dcl-s ws_memberOption   like(ps_memberOption);

    if %parms = 2;
      ws_memberOption = '*NONE';
    else;
      ws_memberOption = ps_memberOption;
    endif;

    callCommand(
    'CPYFRMSTMF FROMSTMF(''' + %trim(ps_streamFile) + ''') ' +
      'TOMBR('''             + %trim(ps_member)       + ''') ' +
      'MBROPT('''            + %trim(ws_memberOption)   + ''')'
    );

  end-proc;
//--------------------------------------------------------------------------------------------------
// Parm 1 /QSYS.LIB/toLib.LIB/toFile.FILE/toMember.MBR
//
// Parm 2 Full IFS path /dir/fullFilename
//
// Parm 3 Optional *NONE *ADD *REPLACE Default *NONE
//
    dcl-proc copyPfMemeberToStreamFile;
    dcl-pi copyPfMemeberToStreamFile;
      ps_streamFile   varchar(256) const;
      ps_member       varchar(256) const;
      ps_memberOption varchar(8)   const options(*nopass:*omit);
    end-pi;

    dcl-s ws_memberOption   like(ps_memberOption);

    if %parms = 2;
      ws_memberOption = '*NONE';
    else;
      ws_memberOption = ps_memberOption;
    endif;

    callCommand(
    'CPYTOSTMF '   +
      'TOSTMF('''  + %trim(ps_streamFile)   + ''') ' +
      'FROMMBR(''' + %trim(ps_member)       + ''') ' +
      'STMFOPT(''' + %trim(ws_memberOption) + ''')'
    );

  end-proc;
/copy cb_rpgle,qcmdexc
/endif

