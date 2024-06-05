**Free
//
// https://www.ibm.com/docs/en/i/7.4?topic=ssw_ibm_i_74/apis/qusrtvus.html
//
// Requiers copybook(s)
//  /copy cb_rpgle,apie0100ds
//
//
/if not defined(QUSRTVUS)
/define QUSRTVUS

  dcl-proc retrieveUserSpace;
    dcl-pi retrieveUserSpace char(1000);
      is_librUserSpace char(10) const;
      is_fileUserSpace char(10) const;
      ii_startPos      int(10) const;
      ii_dataLength    int(10) const;
    end-pi;

    dcl-s ws_qualUserSpace char(20) inz('');  // Libary file name.
    dcl-s rd char(1200) inz('');
    dcl-ds er likeds(dsApiError0100); // Erorr structure

    dcl-pr QUSRTVUS ExtPgm('QUSRTVUS');
      *n  like(ws_qualUserSpace) const; // Required Parameter Group
      *n  like(ii_startPos     ) const; // Required Parameter Group
      *n  like(ii_dataLength   ) const; // Required Parameter Group
      rd  char(1000); // Required Parameter Group
      er  like(dsApiError0100  )      ; // Optional Parameter Group 1
    end-pr;

    %subst(ws_qualUserSpace:1:10)  = is_fileUserSpace;
    %subst(ws_qualUserSpace:11:10) = is_librUserSpace;

//dspMsgWindow(ws_qualUserSpace+'**');

    QUSRTVUS(
      ws_qualUserSpace :
      ii_startPos    :
      ii_dataLength  :
      rd  :
      er
    );

//dspMsgWindow(rd+'**');
    return %trim(rd);
  end-proc;
//
//
//
  dcl-proc rtnUserSpaceHeadder0100;
    dcl-pi rtnUserSpaceHeadder0100 char(200);
      is_librUserSpace char(10) const;
      is_fileUserSpace char(10) const;
    end-pi;

    return retrieveUserSpace(is_librUserSpace:is_fileUserSpace:1:%len(genericHeaderFormat0100));

  end-proc;
/endIf

