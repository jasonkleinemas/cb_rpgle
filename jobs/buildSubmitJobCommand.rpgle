**FREE
/if not defined(buildSubmitJobCommand)
/define buildSubmitJobCommand
//
// Any copybooks needed
//
/copy ../cb_rpgle/text/escapeQuote.rpgle
//
//
//
dcl-proc buildSubmitJobCommand;
  dcl-pi *n                 char(  7);
    isCommand               char(300) value; // Command To Run Job
    isJobName               char( 10) value; // Job Name
    isJobDescription        char( 10) value; // Job Description
    isJobDescriptionLibrary char( 10) value; // Job Description Library
    isJobQueue              char( 10) value; // Job Queue Name
    isJobQueueLibrary       char( 10) value; // Job Queue Library
    isJobPriority           char( 10) value; // Job Priority On JObq
    isOutQueuePriority      char( 10) value; // Job Priority On Outq
    isPrintDevice           char( 10) value; // Print Device
    isOutQueue              char( 10) value; // Out Queue Name
    isOutQueueLibrary       char( 10) value; // Out Queue Library
    isRunAsUser             char( 10) value; // User Name
    isPrintText             char( 30) value; // Print Text
    isRoutingData           char( 80) value; // Routing Data
    isSystemLibraryList     char( 10) value; // System Library List
    isCurrentLibrary        char( 10) value; // Current Library
    isInitialLibraryList    char( 10) value; // initial Library List
    isMessageLogLevel       char(  5) value; // Message Log Level
    isMessageLogSeverity    char(  6) value; // Message Log Severity
    isMessageLogText        char(  7) value; // Message Loggisg Text
    isLogCommand            char(  5) value; // Log CL Program Comnd
    isInquiryMessageReply   char(  8) value; // inquiry message repl
    isAllowWrksbmjob        char(  4) value; // Allow Display wrksbm
    isMessageQueue          char( 10) value; // Message queue
    isMessageQueueLibrary   char( 10) value; // Message queue Lib
    osCommand               char(1000);
  end-pi;

  osCommand = 'SBMJOB';
  if isJobName <> *Blank;
    osCommand = %trimr(osCommand) +  ' JOB(' + %trim(isJobName) + ')';
  endif;

  select;
    when isJobDescription <> *Blank and isJobDescriptionLibrary <> *Blank;
      osCommand = %trimr(osCommand) +  ' JOBD('  + %trim(isJobDescriptionLibrary) + '/' + %trim(isJobDescription) + ')';
    when isJobDescription <> *Blank and isJobDescriptionLibrary  = *Blank;
      osCommand = %trimr(osCommand) +  ' JOBD('  + %trim(isJobDescription) + ')';
    other;
  endsl;

  select;
    when isJobQueue <> *Blank and isJobQueueLibrary <> *Blank;
      osCommand = %trimr(osCommand) +  ' JOBQ('  + %trim(isJobQueueLibrary) + '/' + %trim(isJobQueue) + ')';
    when isJobQueue <> *Blank and isJobQueueLibrary  = *Blank;
      osCommand = %trimr(osCommand) +  ' JOBQ('  + %trim(isJobQueue) + ')';
    other;
  endsl;

  if isJobPriority <> *Blank;
    osCommand = %trimr(osCommand) + ' JOBPTY(' + %trim(isJobPriority) + ')';
  endif;

  if isOutQueuePriority <> *Blank;
    osCommand = %trimr(osCommand) + ' OUTPTY(' + %trim(isOutQueuePriority) + ')';
  endif;

  if isPrintDevice <> *Blank;
    osCommand = %trimr(osCommand) + ' PRTDEV(' + %trim(isPrintDevice) + ')';
  endif;

  select;
    when isOutQueue <> *Blank and isOutQueueLibrary <> *Blank;
      osCommand = %trimr(osCommand) + ' OUTQ('   + %trim(isOutQueueLibrary) + '/' + %trim(isOutQueue) + ')';
    when isOutQueue <> *Blank and isOutQueueLibrary  = *Blank;
      osCommand = %trimr(osCommand) + ' OUTQ('   + %trim(isOutQueue) + ')';
    other;
  endsl;

  if isRunAsUser <> *Blank;
    osCommand = %trimr(osCommand) + ' USER('   + %trim(isRunAsUser) + ')';
  endif;

  if isPrintText  <> *Blank;
    osCommand = %trimr(osCommand) + ' PRTTXT(' + %trim(isPrintText)  + ')';
  endif;

  if isRoutingData  <> *Blank;
    osCommand = %trimr(osCommand) + ' RTGDTA(' + %trim(isRoutingData)  + ')';
  endif;

  if isCommand  <> *Blank;
    osCommand = %trimr(osCommand) + ' RQSDTA(' + ''''+  %trim(EscapeQuote(isCommand))+''')';
  endif;

  if isSystemLibraryList <> *Blank;
    osCommand = %trimr(osCommand) + ' SYSLIBL(' + %trim(isSystemLibraryList) + ')';
  endif;

  if isCurrentLibrary  <> *Blank;
    osCommand = %trimr(osCommand) + ' CURLIB('  + %trim(isCurrentLibrary ) + ')';
  endif;

  if isInitialLibraryList <> *Blank;
    osCommand = %trimr(osCommand) + ' INLLIBL(' + %trim(isInitialLibraryList) + ')';
  endif;

  if isMessageLogLevel <> *Blank and isMessageLogSeverity <> *Blank and isMessageLogText <> *Blank;
    osCommand = %trimr(osCommand) + ' LOG('     + %trim(isMessageLogLevel) + ' ' + %trim(isMessageLogSeverity) + ' ' + %trim(isMessageLogText) + ')';
  endif;

  if isLogCommand <> *Blank;
    osCommand = %trimr(osCommand) + ' LOGCLPGM('+ %trim(isLogCommand) + ')';
  endif;

  if isInquiryMessageReply <> *Blank;
    osCommand = %trimr(osCommand) + ' INQMSGRPY(' + %trim(isInquiryMessageReply) + ')';
  endif;

  if isAllowWrksbmjob <> *Blank;
    osCommand = %trimr(osCommand) + ' DSPSBMJOB(' + %trim(isAllowWrksbmjob) + ')';
  endif;

  select;
    when isMessageQueue <> *Blank and isMessageQueueLibrary <> *Blank;
      osCommand = %trimr(osCommand) +  ' MSGQ('  + %trim(isMessageQueueLibrary) + '/' + %trim(isMessageQueue) + ')';
    when isMessageQueue <> *Blank and isMessageQueueLibrary  = *Blank;
      osCommand = %trimr(osCommand) +  ' MSGQ('  + %trim(isMessageQueue) + ')';
    other;
  endsl;

  return *Blank;
end-proc;
/EndIf

