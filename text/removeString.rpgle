**FREE
/if not defined(removeString)
/define removeString

dcl-proc removeString ;
  dcl-pi *n       varchar(32000);
    is_text       varchar(32000) value;
    is_textRemove    char(    1) value;
  end-pi;
  
  dcl-s pos           int(   10);

  if %trim(is_text) <> *blank;
    pos = %scan(is_textRemove:%trim(is_text));
    dow pos > *zero;
      is_text = %replace('':%trim(is_text):pos:1);
      if %trim(is_text) = *blank;
        leave;
      endIf;
    pos = %scan(is_textRemove:%trim(is_text));
    endDo;
  endIf;
  return is_text;
end-proc;

/endIf 