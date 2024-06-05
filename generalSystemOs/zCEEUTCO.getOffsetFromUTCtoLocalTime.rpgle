**Free
/if not defined(getOffsetFromUTCtoLocalTime_p)
/define getOffsetFromUTCtoLocalTime_p
//
// Make sure to include in the main program
//
// /include ../cb_rpgle/constants/UNIX_EPOCH_START_1970_d.rpgle
//

  dcl-proc getOffsetFromUTCtoLocalTime;
    dcl-pi *n;
      wi_hours int  (10) value; // Hours
      wi_mins  int  (10) value; // Minuets
      wi_secs  float(8 ) value; // Seconds
    end-pi;
  
    dcl-pr ccetco extproc('cceutco');
      *n int  (10) value; // Hours 
      *n int  (10) value; // Minuets
      *n float(8 ) value; // Seconds
      *n char (12) value; // Feed Back
    end-pr;
    
    dcl-s feedback char(12) inz('');
  
    ccetco(wi_hours:wi_mins:wi_secs:feedback);

//    if feedback = 'CEE0000';
//      return *off ; // 1;
//    else;
//      return *on  ; // 0;
//    endif;
  end-proc;

/endif

//cb_rpgle/generalSystemOs/CEEUTCO.getOffsetFromUTCtoLocalTime.rpgle