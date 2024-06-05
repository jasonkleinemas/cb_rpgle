**Free
/if not defined(firstLetterOfEachWordUpper_p)
/define firstLetterOfEachWordUpper_p

  dcl-proc firstLetterOfEachWordUpper;
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
    
    %subst(ws_text: 1: 1) = %upper(%subst(ws_text: 1: 1));

    for wi_ctr = 1 to %charcount(ws_text);
      if *blank = %subst(ws_text: wi_ctr: 1);
        wi_ctr += 1;
        if wi_ctr > %charcount(ws_text);
          leave;
        endif;
        %subst(ws_text: wi_ctr: 1) = %upper(%subst(ws_text: wi_ctr: 1));
      endif;
    endfor;
    
    return ws_text;

  end-proc;

/endif
