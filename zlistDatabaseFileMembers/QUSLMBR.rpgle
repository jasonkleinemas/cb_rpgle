**Free
//
// https://www.ibm.com/docs/en/i/7.2?topic=ssw_ibm_i_72/apis/quslmbr.html
//
// IBM API List Database File Members
//
// Requiers copybook(s)
//  /copy cb_rpgle,apie0100ds
//
//
/if not defined(QUSLMBR)
/define QUSLMBR

  dcl-proc listDatabaseFileMembers;
    dcl-pi listDatabaseFileMembers Char(7);
      is_librUserSpace char(10) const;
      is_fileUserSpace char(10) const;
      is_librReadName  char(10) const;
      is_fileReadName  char(10) const;
    end-pi;

    dcl-ds er likeds(dsApiError0100); // Erorr structure

    dcl-s ws_qualUserSpace char(20) inz('');  // Libary file name.
    dcl-s ws_formatName    char(10) inz('MBRL0200  ');
    dcl-s ws_qualReadFile  char(20) inz('');  // Libary file name.
    dcl-s ws_membReadName  char(10) inz('*ALL');
    dcl-s ws_ovrrdPrcssng  char(1)  inz('1');

    dcl-pr QUSLMBR ExtPgm('QUSLMBR');
      *n  like(ws_qualUserSpace) const; // Required Parameter Group
      *n  like(ws_formatName   ) const; // Required Parameter Group
      *n  like(ws_qualReadFile ) const; // Required Parameter Group
      *n  like(ws_membReadName ) const; // Required Parameter Group
      *n  like(ws_ovrrdPrcssng ) const; // Required Parameter Group
      er  like(dsApiError0100  )      ; // Optional Parameter Group 1
    end-pr;

    %subst(ws_qualReadFile:1:10)  = is_fileReadName;
    %subst(ws_qualReadFile:11:10) = is_librReadName;

    %subst(ws_qualUserSpace:1:10)  = is_fileUserSpace;
    %subst(ws_qualUserSpace:11:10) = is_librUserSpace;

    QUSLMBR(
      ws_qualUserSpace :
      ws_formatName    :
      ws_qualReadFile  :
      ws_membReadName  :
      ws_ovrrdPrcssng  :
      er
    );

    return er.dae1_exceptionID;
  end-proc;
/endIf
