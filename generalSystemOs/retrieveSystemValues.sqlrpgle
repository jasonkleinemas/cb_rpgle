**Free
/if not defined(retrieveSystemValues_p)
/define retrieveSystemValues_p

  dcl-proc rst_getTimeZoneUTC;
    dcl-pi *n char(5);
    end-pi;
    
    return retrieveSystemValues('QUTCOFFSET');
    
  end-proc;

  dcl-proc retrieveSystemValues;
    dcl-pi *n varchar(1280);
      is_name varchar(10) const ;
    end-pi;
    
    dcl-ds svi qualified dim(1) ;
      name    char  (10  );
      valNum  packed(10  );
      valChar char  (1280) nullind;
    end-ds ;

    dcl-ds inNulls qualified dim(1);
      nullInds int(5) dim(3);
    end-ds;

    dcl-s rows   int    (10  ) inz(%elem(svi)) ;
    dcl-s retVal varchar(1280) inz('') ;

    exec sql
      DECLARE c1 CURSOR FOR
      SELECT 
        SYSTEM_VALUE_NAME,
        CURRENT_NUMERIC_VALUE,
        CAST(CURRENT_CHARACTER_VALUE AS CHAR(1280) CCSID 37)
      FROM 
        QSYS2.SYSTEM_VALUE_INFO
      WHERE 
        SYSTEM_VALUE_NAME LIKE :is_name
      FETCH FIRST ROW ONLY ;

    exec sql OPEN c1 ;

    exec sql FETCH c1 FOR :rows ROWS INTO :svi :inNulls;
    if SQLSTATE = '02000';
      exec sql CLOSE c1 ;
      return 'No Records';
    endif;
    exec sql CLOSE c1 ;

    if inNulls(1).nullInds(3) = -1;
      retVal = %char(svi(1).valNum);
    else;
      retVal = svi(1).valChar;
    endif;
    
    return retVal;
  
  end-proc;
  
/endif
