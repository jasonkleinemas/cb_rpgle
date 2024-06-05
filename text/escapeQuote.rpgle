**FREE
/if not defined(escapeQuote)
/define escapeQuote

dcl-proc escapeQuote;
  dcl-pi *n          char(1000);
    is_text          char(1000) Value;
  end-pi;
  dcl-s ws_text      char(1000) inz('');
  dcl-s wi_pos        int(   5) inz(0);

  wi_pos = %scan(X'7D':is_text);
  if wi_pos <> *Zero;
    dow wi_pos <> *Zero;
      ws_text = %replace('''''': is_text: wi_pos: 1);
      wi_pos = wi_pos + 2;
      wi_pos = %scan(X'7D':ws_text:wi_pos );
      if wi_pos = *Zero;
        leave;
      endif;
      is_text = ws_text;
    enddo;
  else;
    ws_text = is_text;
  endif;

  return ws_text;
end-proc;

dcl-proc EscapeQuote5000;
  dcl-pi *n          char(5000);
    is_text          char(5000) Value;
  end-pi;
  dcl-s ws_text      char(5000) inz('');
  dcl-s wi_pos        int(   5) inz(0);

  wi_pos = %scan(X'7D':is_text);
  if wi_pos <> *Zero;
    dow wi_pos <> *Zero;
      ws_text = %replace('''''': is_text: wi_pos: 1);
      wi_pos = wi_pos + 2;
      wi_pos = %scan(X'7D':ws_text:wi_pos );
      if wi_pos = *Zero;
        leave;
      endif;
      is_text = ws_text;
    enddo;
  else;
    ws_text = is_text;
  endif;

  return ws_text;
end-proc;
/endIf

