**Free
/if not defined(buildSbmJobCmdBasic_p)
/define buildSbmJobCmdBasic_p

dcl-proc buildSbmJobCmdBasic;
  dcl-pi *n varchar(600);
    is_cmd     char(500) value; // CMD     Command To Run Job
    is_jobName     char(10 ) value; // JOB     Job Name
    is_jobDesc    char(10 ) value; // JOBD    Job Description
    is_jobLib char(10 ) value; // JOBDLIB Job Description Lib
    is_jobQ    char(10 ) value; // JOBQ    Job Queue Name
    is_jobQLib char(10 ) value; // JOBQLIB Job Queue Library
    is_jobPriorityJobQ  char(10 ) value; // JOBPTY  Job Priority On JObq
    is_jobPriorityOutQ  char(10 ) value; // OUTPTY  Job Priority On Outq
    is_printDev  char(10 ) value; // PRTDEV  Print Device
    is_outQ    char(10 ) value; // OUTQ    Out Queue Name
    is_outQLib char(10 ) value; // OUTQLIB Out Queue Library
    
    is_runUser char(10 ) value; // RUNUSER User Name
    is_printText  char(30 ) value; // PRTTXT  Print Text
    is_routingData  char(80 ) value; // RTGDTA  Routing Data
    is_sysLibL char(10 ) value; // SYSLIBL System Library List
    is_currentLibL  char(10 ) value; // CURLIB  Current Library
    is_intiialLibL char(10 ) value; // INLLIBL Initial Library List
    is_messageLogLevel char(5  ) value; // MSGLOGL Message Log Level
    is_messageLogSeverity char(6  ) value; // MSGLOGS Message Log Severoty
    is_messageLogServrity char(7  ) value; // MSGLOGT Message Logging Text
    is_logClPgmCmd char(5  ) value; // LOGCLPG Log CL Program Comnd
    is_ char(8  ) value; // INQMSGR Inquiry message repl
    is_DSPSBMJ char(4  ) value; // DSPSBMJ Allow Display wrksbm
    is_MSGQ    char(10 ) value; // MSGQ    Message queue
    is_MSGQLIB char(10 ) value; // MSGQLIB Message queue Lib
  end-pi;

  dcl-s rtnStr varchar(600) inz('SBMJOB');

  if InJOBNAME <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) +  ' JOB(' +                        //  I Setup the JOB
    %trim(InJOBNAME) + ')';                                           //  I
  endif;                                                              // -/

  select;                                                             // -\ Setup the JOBD
    when InJOBD <> *Blank And InJOBDLIB <> *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) +  ' JOBD('  +                    //  I
      %trim(InJOBDLIB) + '/' + %trim(InJOBD) + ')';                   //  I
/End-Free
// >>>>> Not converted: Conversion not currently supported.
                                                                      //    I
/Free
    when InJOBD <> *Blank And InJOBDLIB  = *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) +  ' JOBD('  +                    //  I
      %trim(InJOBD) + ')';                                            //  I
    other;                                                            // <I
  endsl;                                                              // -/

  select;                                                             // -\ Setup the JOBQ
    when InJOBQ <> *Blank And InJOBQLIB <> *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) +  ' JOBQ('  +                    //  I
      %trim(InJOBQLIB) + '/' + %trim(InJOBQ) + ')';                   //  I
/End-Free
// >>>>> Not converted: Conversion not currently supported.
                                                                          I
/Free
    when InJOBQ <> *Blank And InJOBQLIB  = *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) +  ' JOBQ('  +                    //  I
      %trim(InJOBQ) + ')';                                            //  I
    other;                                                            // <I
  endsl;                                                              // -/

  if InJOBPTY <> *Blank;                                              // -\
    OutCmdStr = %trimr(OutCmdStr) + ' JOBPTY(' +                      //  I Setup the JOBPTY
    %trim(InJOBPTY) + ')';                                            //  I
  endif;                                                              // -/

  if InOUTPTY <> *Blank;                                              // -\
    OutCmdStr = %trimr(OutCmdStr) + ' OUTPTY(' +                      //  I Setup the OUTPTY
    %trim(InOUTPTY) + ')';                                            //  I
  endif;                                                              // -/

  if InPRTDEV <> *Blank;                                              // -\
    OutCmdStr = %trimr(OutCmdStr) + ' PRTDEV(' +                      //  I Setup the PRTDEV
    %trim(InPRTDEV) + ')';                                            //  I
  endif;                                                              // -/

  select;                                                             // -\ Setup the OUTQ
    when InOUTQ <> *Blank And InOUTQLIB <> *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) + ' OUTQ('   +                    //  I InOUTQ
      %trim(InOUTQLIB) + '/' + %trim(InOUTQ) + ')';                   //  I InOUTQLIB
/End-Free
// >>>>> Not converted: Conversion not currently supported.
                                                                          I
/Free
    when InOUTQ <> *Blank And InOUTQLIB  = *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) + ' OUTQ('   +                    //  I
      %trim(InOUTQ) + ')';                                            //  I
    other;                                                            // <I
  endsl;                                                              // -/

  if InRUNUSER <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' USER('   +                      //  I Setup the USER
    %trim(InRUNUSER) + ')';                                           //  I InRUNUSER
  endif;                                                              // -/

  if InPRTTXT  <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' PRTTXT(' +                      //  I Setup the PRTTXT
    %trim(InPRTTXT)  + ')';                                           //  I InPRTTXT
  endif;                                                              // -/

  if InRTGDTA  <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' RTGDTA(' +                      //  I Setup the RTGDTA
    %trim(InRTGDTA)  + ')';                                           //  I InRTGDTA
  endif;                                                              // -/

  if InRUNCMD  <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' RQSDTA(' +                      //  I Setup the RQSDTA
    ''''+  %trim(EscapeQuote(InRUNCMD))+''')';                        //  I InRUNCMD
  endif;                                                              // -/

  if InSYSLIBL <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' SYSLIBL(' +                     //  I Setup the SYSLIBL
    %trim(InSYSLIBL) + ')';                                           //  I InSYSLIBL
  endif;                                                              // -/

  if InCURLIB  <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' CURLIB('  +                     //  I Setup the CURLIB
    %trim(InCURLIB ) + ')';                                           //  I InCURLIB
  endif;                                                              // -/

  if InINLLIBL <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' INLLIBL(' +                     //  I Setup the INLLIBL
    %trim(InINLLIBL) + ')';                                           //  I InINLLIBL
  endif;                                                              // -/

  if InMSGLOGL <> *Blank And InMSGLOGS <> *Blank                      // -\ Setup the Logging
  and InMSGLOGT <> *Blank;                                            // -I InMSGLOGL
    OutCmdStr = %trimr(OutCmdStr) + ' LOG('     +                     //  I InMSGLOGS
    %trim(InMSGLOGL) + ' ' + %trim(InMSGLOGS)   +                     //  I InMSGLOGT
    ' ' + %trim(InMSGLOGT) + ')';                                     //  I
  endif;                                                              // -/

  if InLOGCLPG <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) + ' LOGCLPGM('+                     //  I Setup the LOGCLPG
    %trim(InLOGCLPG) + ')';                                           //  I InLOGCLPG
  endif;                                                              // -/

  if InINQMSGR <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) +                                   //  I Setup the INQMSGR
    ' INQMSGRPY(' +      %trim(InINQMSGR) + ')';                      //  I InINQMSGR
  endif;                                                              // -/

  if InDSPSBMJ <> *Blank;                                             // -\
    OutCmdStr = %trimr(OutCmdStr) +                                   //  I Setup the DSPSBMJ
    ' DSPSBMJOB(' +      %trim(InDSPSBMJ) + ')';                      //  I InDSPSBMJ
  endif;                                                              // -/

  select;                                                             // -\ Setup the MSGQ
    when InMSGQ <> *Blank And InMSGQLIB <> *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) +  ' MSGQ('  +                    //  I InMSGQ
      %trim(InMSGQLIB) + '/' + %trim(InMSGQ) + ')';                   //  I InMSGQLIB
/End-Free
// >>>>> Not converted: Conversion not currently supported.
                                                                          I
/Free
    when InMSGQ <> *Blank And InMSGQLIB  = *Blank;                    // <I
      OutCmdStr = %trimr(OutCmdStr) +  ' MSGQ('  +                    //  I
      %trim(InMSGQ) + ')';                                            //  I
    other;                                                            // <I
  endsl;                                                              // -/



  return *Blank;
end-proc;
/endif


