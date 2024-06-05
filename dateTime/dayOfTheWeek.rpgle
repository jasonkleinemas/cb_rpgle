**FREE
/if not defined(dayOfTheWeek)
/define dayOfTheWeek

dcl-proc dayOfTheWeek;
  dcl-pi *n       packed(1:0);
    i_dateIso       char( 10) options(*nopass) const; // 0001-01-01
//    i_starOfTheWeek char(  1) options(*nopass) const; // M for Monday, S for sunday
  end-pi;
  
  if %parms() = 0;
    return %rem(%diff(%date():d'0001-01-01':*days):7) + 1;
  endIf;

  test(de) *iso i_dateIso;
  if %error;
    return -1;
  endIf;

  return %rem(%diff(%date(i_dateIso):d'0001-01-01':*days):7) + 1;

end-proc;
/endIf