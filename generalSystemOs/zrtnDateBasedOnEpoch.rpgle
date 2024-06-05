**Free                                                                                                     
/if not defined(rtnDateBasedOnEpoch)
/define rtnDateBasedOnEpoch

/copy ../cb_rpgle/generalSystemOs/retrieveSystemValues.sqlrpgle

//
// Returns an *iso date
//            Ex: 1990-01-01-00.00.00.000000
  dcl-proc rtnDateBasedOnEpoch;                                                                               
    dcl-pi *n char(26);                                                       
     ii_seconds uns(10) value;    // Number of seconds
    end-pi;
                                  //  Since
    dcl-s rtnDate  char(26)  inz; //  1970-01-01-00.00.00
    dcl-s epochD   timeStamp Inz(z'1970-01-01-00.00.00');
    dcl-s workDate timeStamp Inz;

    dcl-ds tz qualified;
      dir   char (1  );
      hour  zoned(2:0);
      frac  zoned(2:0);
    end-ds;

    workDate = EpochD + %seconds(ii_seconds);
    
    tz = rst_getTimeZoneUTC();

    if tz.dir = '-';
      workDate -= %hours(tz.hour);
    else;
      workDate += %hours(tz.hour);
    endif;

    rtnDate = %char(workDate);

    return rtnDate;
    
  end-proc;

/endif
