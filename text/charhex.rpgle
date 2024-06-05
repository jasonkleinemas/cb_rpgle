**Free
/if not defined(cvthccvtch_d)
/define cvthccvtch_d


/if defined(comment)
  dcl-pr char2hex extproc('cvthc') ;    // Convert char to hex
    *n pointer value options(*string);  // Hex out
    *n pointer value options(*string);  // Char in
    *n int(10) value ;                  // Length of string in
  end-pr;
  dcl-pr hex2char extproc('cvtch') ;    // Convert hex to char
    *n pointer value options(*string);  // Char out
    *n pointer value options(*string);  // Hex in
    *n int(10) value ;                  // Length
  end-pr ;
/endif


//
//-----------------------------------------------------------------------------------------------------
//
  dcl-proc char2hex;                    // Convert char to hex
    dcl-pi *n varchar(2000) ;           // Hex out
      is_txt varchar(1000) const;       // Char in
    end-pi;
    
    dcl-pr cvthc extproc('cvthc') ;     // Convert char to hex
      *n char(2000) options(*varsize);  // Hex out
      *n char(1000) options(*varsize);  // Char in
      *n int(10) value ;                // Length of string in
    end-pr;

    dcl-s os_hex  char(2000);
    dcl-s os_txt  char(1000);
    
    os_txt = is_txt;
    cvthc(os_hex:os_txt:%charcount(is_txt)*2);
    
    return %subst(os_hex:1:%charcount(is_txt)*2);

  end-proc;
//
//-----------------------------------------------------------------------------------------------------
//
  dcl-proc hex2char;                  // Convert hex to char
    dcl-pi *n varchar(2000) ;         // Hex out
      is_hex  varchar(1000) const;    // Char in
    end-pi ;

  dcl-pr cvtch extproc('cvtch') ;     // Convert hex to char
    *n char(2000) options(*varsize);  // Char out
    *n char(1000) options(*varsize);  // Hex in
    *n int(10) value ;                // Length
  end-pr ;
  
    dcl-s os_hex  char(2000);
    dcl-s os_txt  char(1000);
    
    os_hex = is_hex;
    cvtch(os_txt:os_hex:%charcount(is_hex));
        
    return %subst(os_txt:1:%div(%charcount(is_hex):2));
    

  end-proc;

/endif
