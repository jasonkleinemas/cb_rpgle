**Free
/if not defined(centerText)
/define centerText
//
//
//
  dcl-proc centerText;
    dcl-pi *n     varchar(100);
      is_text     char(100) const;
      ii_fieldLen int (3  ) const;
    end-pi;

    dcl-s wi_inStrLen  int (3  ) inz(0 );
    dcl-s wi_startPos  int (3  ) inz(0 );
    dcl-s ws_retString char(100) inz('');

    wi_inStrLen = %len(%trim(is_text));

    if wi_inStrLen >= ii_fieldLen;
      return is_text;
    endIf;

    wi_startPos = ((ii_fieldLen - wi_inStrLen)/2) + 1;
    wi_inStrLen = %len(%trim(is_text));

    if wi_inStrLen < 1;
      return is_text;
    endif;

    %subst(ws_retString : wi_startPos) = %trim(is_text);

    return ws_retString;
        
  end-proc;
/endif
