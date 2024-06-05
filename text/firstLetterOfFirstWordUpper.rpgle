**Free
/if not defined(firstLetterOfFirstWordUpper_p)
/define firstLetterOfFirstWordUpper_p

  dcl-proc firstLetterOfFirstWordUpper;
    dcl-pi *n varchar(32000);
      is_text varchar(32000) const;
      in_lower ind const options(*nopass:*omit);
    end-pi;
    
    dcl-s ws_text varchar(32000) inz('');
    dcl-s wi_ctr int(10) inz(1);
    
    ws_text = is_text;

// Wait for ptf SI83497    
//    if %passed(in_lower);

    if %parms() > 1;
      if in_lower = *on;
        ws_text = %lower(is_text);
      endif;
    endif;
    
    wi_ctr = %check(' ':ws_text);
    %subst(ws_text:wi_ctr:1) = %upper(%subst(ws_text:wi_ctr:1));
    
    return ws_text;
    
  end-proc;
    
/endif