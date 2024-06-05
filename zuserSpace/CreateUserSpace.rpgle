**Free
//
// https://www.ibm.com/docs/en/i/7.3?topic=ssw_ibm_i_73/apis/quscrtus.html
//
// Requiers copybook(s)
//  /copy cb_rpgle,apie0100d
//
//
/if not defined(QUSCRTUS)
/define QUSCRTUS

  dcl-proc CreateUserSpace;
    dcl-pi CreateUserSpace Char(7);
      is_userSpaceLib  char(10) const;
      is_userSpaceFile char(10) const;
      is_attribute     char(10) const;
      is_description   char(50) const;
    end-pi;

    dcl-ds er likeds(dsApiError0100); // Erorr structure

    dcl-s ws_qualUserSpace char(20) inz('');
    dcl-s wi_initalSize    int(10)  inz(1);
    dcl-s ws_initalValue   char(1)  inz('');
    dcl-s ws_publicAuthor  char(10) inz('*ALL');
    dcl-s ws_replace       char(10) inz('*YES');

    dcl-pr QUSCRTUS extPgm('QUSCRTUS');
      *n  like(ws_qualUserSpace) const; // Required Parameter Group
      *n  like(is_attribute    ) const; // Required Parameter Group
      *n  like(wi_initalSize   ) const; // Required Parameter Group
      *n  like(ws_initalValue  ) const; // Required Parameter Group
      *n  like(ws_publicAuthor ) const; // Required Parameter Group
      *n  like(is_description  ) const; // Required Parameter Group
      *n  like(ws_replace      ) const; // Optional Parameter Group 1
      er  like(dsApiError0100  )      ; // Optional Parameter Group 1
    end-pr;

    %subst(ws_qualUserSpace:1:10)  = is_userSpaceFile;
    %subst(ws_qualUserSpace:11:10) = is_userSpaceLib;

    QUSCRTUS(
      ws_qualUserSpace :
      is_attribute     :
      wi_initalSize    :
      ws_initalValue   :
      ws_publicAuthor  :
      is_Description   :
      ws_replace       :
      er
    );

    return er.dae1_exceptionID;
  end-proc;
/endIf

