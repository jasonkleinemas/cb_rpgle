**Free

/if not defined(formatName)
/define formatName
                                
/copy ../cb_rpgle/text/firstLetterOfEachWordUpper.rpgle

//
// Retun The Name As First Last.
//
  dcl-proc formatNameFirstLast;
    dcl-pi *n varchar(205);
      is_firstName char(100) value;
      is_lastName  char(100) value;
    end-pi;
    
    dcl-s ws_rtn varchar(205) inz;

    ws_rtn = %trim(firstLetterOfEachWordUpper(is_firstName:*on)) + ' ' +  %trim(firstLetterOfEachWordUpper(is_lastName:*on));
    
    ws_rtn = formatName_suffixes(ws_rtn); 
    
    return ws_rtn;
  
  end-proc;
//
// Retun The Name As Last, First
//
  dcl-proc formatNameLastFirst;
    dcl-pi *n varchar(205);
      is_firstName char(100) value;
      is_lastName  char(100) value;
    end-pi;

    dcl-s ws_rtn varchar(205) inz;

    ws_rtn = %trim(firstLetterOfEachWordUpper(is_lastName)) + ', ' + %trim(firstLetterOfEachWordUpper(is_firstName));
    
    ws_rtn = formatName_suffixes(ws_rtn);
    
    return ws_rtn;
    
  end-proc;
//
//
//
  dcl-proc formatName_suffixes;
    dcl-pi *n varchar(205);
      is_temp char(205) value;
    end-pi;

    dcl-s pos uns(3) inz(0);
    
    pos = %scan(' Ii ':is_temp);
    if 0 <> pos;
      %subst(is_temp:pos:3) = ' II';
    endif;

    pos = %scan(' Iii ':is_temp);
    if 0 <> pos;
      %subst(is_temp:pos:4) = ' III';
    endif;
    
    pos = %scan(' Iv ':is_temp);
    if 0 <> pos;
      %subst(is_temp:pos:3) = ' IV';
    endif;    
    
    return %trim(is_temp);

  end-proc;
  
/endif
