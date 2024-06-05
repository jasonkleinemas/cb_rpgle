**FREE
//
// If any of these are need. 
// It needs to be split out to it's own file.
// Look at for examples
// src/cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0100.rpgle
// src/cb_rpgle/jobs/retrieveJobInformation.jobio0100.rpgle
//
//COPY QMISCCOPY,GETTIME_P
//
//
//
/if not defined(getJobInfo)
/define getJobInfo

//#----------------------------------------------------------------------------

//#----------------------------------------------------------------------------
dcl-proc GetJobInfo0200;
  dcl-pi GetJobInfo0200       char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char(6) value;
    JobStatus                char(10);                                // Job Status
    JobType                  char(1);                                 // Job Type
    JobSubType               char(1);                                 // Job Subtype
    JobSubSysName            char(10);                                // Subsys Name
    JobRunPriority            int(10:0);                              // Run Priority
    JobSubSysPoolI            int(10:0);                              // System Pool ID
    JobCPUUsed                int(10:0);                              // CPU Used
    JobAuxIOReques            int(10:0);                              // Aux IO Request
    Job#InteraTran            int(10:0);                              // Interact Trans
    JobReaponseTm             int(10:0);                              // Response Time
    JobFunctionTyp           char(1);                                 // Function Type
    JobFunctionNam           char(10);                                // Function Name
    JobActJobStat            char(4);                                 // Active Job Stat
     Job#DataLockW             int(10:0);                             // Num DBase Lock Wts
   Job#nonDataLW             int(10:0);                              /// Num Internal Mch Lck
   Job#IntDATALW             int(10:0);                              /// Num Non DBase Lock W
   JobWaitTime1              int(10:0);                              /// Wait Time DBase Lock
   JobWaitTime2              int(10:0);                              /// Wait Time Internal M
    JobWaitTime3              int(10:0);                              // Wait Time Non DBase
    JobCurrSysPool            int(10:0);                              // Current System Pool
    JobThreadCount            int(10:0);                              // Thread Count
  end-pi;

  dcl-ds ds_jobIo100;                                                   // Qwc JOBI0200
    jobIo100.bytesReturned01                   int(10:0);                              // Bytes Return
    jobIo100.bytesAvailable01                   int(10:0);                              // Bytes Avail
    QUSJN03                  char(10);                                // Job Name
    QUSUN03                  char(10);                                // User Name
    QUSJNBR03                char(6);                                 // Job Number
    jobIo100.internalJobIdentifier01                char(16) inz;                            // Int Job ID
    QUSJS05                  char(10);                                // Job Status
    QUSJT04                  char(1);                                 // Job Type
    QUSJS06                  char(1);                                 // Job Subtype
    QUSSN                    char(10);                                // Subsys Name
    jobIo100.jobRunPriority01                   int(10:0);                              // Run Priority
    systemPoolIdentifier00                 int(10:0);                              // System Pool ID
    processingUnitTime00                 int(10:0);                              // CPU Used
    QUSAIOR                   int(10:0);                              // Aux IO Request
    QUSIT                     int(10:0);                              // Interact Trans
    QUSRT                     int(10:0);                              // Response Time
    QUSFT                    char(1);                                 // Function Type
    QUSFN15                  char(10);                                // Function Name
    QUSAJS                   char(4);                                 // Active Job Stat
     QUSNDBLW                  int(10:0);                             // Num DBase Lock Wts
   QUSNIMLW                  int(10:0);                              /// Num Internal Mch Lck
   QUSNDBLW00                int(10:0);                              /// Num Non DBase Lock W
   QUSTDBLW                  int(10:0);                              /// Wait Time DBase Lock
   QUSTIMLW                  int(10:0);                              /// Wait Time Internal M
    QUSNDBLW01                int(10:0);                              // Wait Time Non DBase
    QUSERVED45               char(1);                                 // Reserved
    QUSCSPID                  int(10:0);                              // Current System Pool
    QUSTC01                   int(10:0);                              // Thread Count
  end-ds;


  dcl-ds QUSErr                Len(116) inz;
    QUSBPRV                   int(10:0) inz(116);
    jobIo100.bytesAvailableVL                   int(10:0) inz(0);
    QUSEI                    char(7) inz;
    QUSERVED                 char(1) inz;
    QUSED01                  char(100) inz;
  end-ds;

  dcl-s FormatName            char(8) inz('JOBI0200');
  dcl-s ReceiveLen             int(10:0) inz(187);
  dcl-s JobNameFull           char(26) inz;
  dcl-s IntJobName            char(16) inz;

  %subst(JobNameFull:1:10) = JobName;
  %subst(JobNameFull:11:10) = JobUser;
  %subst(JobNameFull:21:6) = JobNumber;

// >>>>> Automatically removed by conversion
//C                   Call      'QUSRJOBI'

  callp QUSRJOBI(
                ds_jobIo100
                :ReceiveLen
                :FormatName
                :JobNameFull
                :IntJobName
                :QusErr
                );

//C                   Parm                    ds_jobIo100
//C                   Parm                    ReceiveLen
//C                   Parm                    FormatName
//C                   Parm                    JobNameFull
//C                   Parm                    IntJobName
//C                   Parm                    QusErr

  JobStatus      = QUSJS05;
  JobType        = QUSJT04;
  JobSubType     = QUSJS06;
  JobSubSysName  = QUSSN;
  JobRunPriority = jobIo100.jobRunPriority01;
  JobSubSysPoolI = systemPoolIdentifier00;
  JobCPUUsed     = processingUnitTime00;
  JobAuxIOReques = QUSAIOR;
  Job#InteraTran = QUSIT;
  JobReaponseTm  = QUSRT;
  JobFunctionTyp = QUSFT;
  JobFunctionNam = QUSFN15;
  JobActJobStat  = QUSAJS;
  Job#DataLockW  = QUSNDBLW;
  Job#nonDataLW  = QUSNIMLW;
  Job#IntDATALW  = QUSNDBLW00;
  JobWaitTime1   = QUSTDBLW;
  JobWaitTime2   = QUSTIMLW;
  JobWaitTime3   = QUSNDBLW01;
  JobCurrSysPool = QUSCSPID;
  JobThreadCount = QUSTC01;

  return *Blank;
end-proc;
//#----------------------------------------------------------------------------
/if defined(comment)
dcl-proc GetJobInfo0300;
  dcl-pi GetJobInfo0300       char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char(6) value;
    JobStatus                char(10);                                // Job Status
    JobType                  char(1);                                 // Job Type
    JobSubType               char(1);                                 // Job Subtype
    JobQueueName             char(10);                                // Jobq Name
    JobQueueLibNam           char(10);                                // Jobq Lib
    JobJobQueuePri           char(2);                                 // Jobq Priority
    JobOutQueueNam           char(10);                                // Outq Name
    JobOutQueueLib           char(10);                                // Outq Lib
    JobOutQueuePri           char(2);                                 // Outq Priority
    JobPrintDevNam           char(10);                                // Prt Dev Name
    JobSubmJobName           char(10);                                // Subm Job Name
    JobSubmUserNam           char(10);                                // Subm User Name
    JobSubmJobNum            char(6);                                 // Subm Job Num
    JobSubmMsgQueu           char(10);                                // Subm Msgq Name
    JobSubmMsgLib            char(10);                                // Subm Msgq Lib
    JobStatQueue             char(10);                                // Sts On Jobq
    JobDateOnQueue           char(26);                                // Date Put On Jobq
    JobDate                  char(8);                                 // Job Date
  end-pi;

  dcl-ds ds_jobIo100;                                                   // Qwc JOBI0300
    jobIo100.bytesReturned02                   int(10:0);                              // Bytes Return
    jobIo100.bytesAvailable02                   int(10:0);                              // Bytes Avail
    QUSJN04                  char(10);                                // Job Name
    QUSUN04                  char(10);                                // User Name
    QUSJNBR04                char(6);                                 // Job Number
    jobIo100.internalJobIdentifier02                char(16) inz;                            // Int Job ID
    QUSJS07                  char(10);                                // Job Status
    QUSJT05                  char(1);                                 // Job Type
    QUSJS08                  char(1);                                 // Job Subtype
    QUSJN05                  char(10);                                // Jobq Name
    QUSJL                    char(10);                                // Jobq Lib
    QUSJP                    char(2);                                 // Jobq Priority
    QUSON                    char(10);                                // Outq Name
    QUSOL                    char(10);                                // Outq Lib
    QUSOP                    char(2);                                 // Outq Priority
    QUSPDN                   char(10);                                // Prt Dev Name
    QUSSJN                   char(10);                                // Subm Job Name
    QUSSUN                   char(10);                                // Subm User Name
    QUSSJNBR                 char(6);                                 // Subm Job Num
    QUSSMN                   char(10);                                // Subm Msgq Name
    QUSSML                   char(10);                                // Subm Msgq Lib
    QUSSOJ                   char(10);                                // Sts On Jobq
    QUSDPOJ                  char(8);                                 // Date Put On Jobq
    QUSJD                    char(7);                                 // Job Date
  end-ds;

  dcl-ds QUSErr                Len(116) inz;
    QUSBPRV                   int(10:0) inz(116);
    jobIo100.bytesAvailableVL                   int(10:0) inz(0);
    QUSEI                    char(7) inz;
    QUSERVED                 char(1) inz;
    QUSED01                  char(100) inz;
  end-ds;

  dcl-s FormatName            char(8) inz('JOBI0300');
  dcl-s ReceiveLen             int(10:0) inz(187);
  dcl-s JobNameFull           char(26) inz;
  dcl-s IntJobName            char(16) inz;
  dcl-s TempS                 char(30) inz;

  %subst(JobNameFull:1:10) = JobName;
  %subst(JobNameFull:11:10) = JobUser;
  %subst(JobNameFull:21:6) = JobNumber;

// >>>>> Automatically removed by conversion
//C                   Call      'QUSRJOBI'

  callp QUSRJOBI(
                ds_jobIo100
                :ReceiveLen
                :FormatName
                :JobNameFull
                :IntJobName
                :QusErr
                );

//C                   Parm                    ds_jobIo100
//C                   Parm                    ReceiveLen
//C                   Parm                    FormatName
//C                   Parm                    JobNameFull
//C                   Parm                    IntJobName
//C                   Parm                    QusErr

  JobStatus      = QUSJS07;
  JobType        = QUSJT05;
  JobSubType     = QUSJS08;
  JobQueueName   = QUSJN05;
  JobQueueLibNam = QUSJL;
  JobJobQueuePri = QUSJP;
  JobOutQueueNam = QUSON;
  JobOutQueueLib = QUSOL;
  JobOutQueuePri = QUSOP;
  JobPrintDevNam = QUSPDN;
  JobSubmJobName = QUSSJN;
  JobSubmUserNam = QUSSUN;
  JobSubmJobNum  = QUSSJNBR;
  JobSubmMsgQueu = QUSSMN;
  JobSubmMsgLib  = QUSSML;
  JobStatQueue   = QUSSOJ;
  JobDateOnQueue = QUSDPOJ;
  if QUSJD = '*SYSVAL';                                               // ---\
    TempS = GetTime;                                                  //    I
    JobDate = %subst(TempS:1:4) +                                     //    I
    %subst(TempS:6:2) +                                               //    I
    %subst(TempS:9:2);                                                //    I
  else;                                                               // --<I
    select;                                                           // -\ I
      when '0' = %subst(QUSJD:1:1);                                   // <I I
        JobDate = '19' + %subst(QUSJD:2:6);                           //  I I
      when '1' = %subst(QUSJD:1:1);                                   // <I I
        JobDate = '20' + %subst(QUSJD:2:6);                           //  I I
      when '2' = %subst(QUSJD:1:1);                                   // <I I
        JobDate = '21' + %subst(QUSJD:2:6);                           //  I I
      when '3' = %subst(QUSJD:1:1);                                   // <I I
        JobDate = '22' + %subst(QUSJD:2:6);                           //  I I
      other;                                                          // <I I
        JobDate = '20' + %subst(QUSJD:2:6);                           //  I I
    endsl;                                                            // -/ I
  endif;                                                              // ---/

  return *Blank;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc GetJobInfo0400;
  dcl-pi GetJobInfo0400       char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char(6) value;
    JobStatus                char(10);                                // Job Status
    JobType                  char(1);                                 // Job Type
    JobSubType               char(1);                                 // Job Subtype
    JobDateEntSys            char(26);                                // Date Enter Sys
    JobDateJobAct            char(26);                                // Date Job Active
    JobAcctCose              char(15);                                // Job Acct Code
    JobDescName              char(10);                                // Job Desc Name
    JobDescLib               char(10);                                // Job Desc Lib
    JobUnitWorkID            char(24);                                // Unit Work ID
    JobModeName              char(8);                                 // Mode Name
    JobInqMshReply           char(10);                                // Inq Msg Reply
    JobLogClPgms             char(10);                                // Log Cl Pgms
    JobBrkMsgHndl            char(10);                                // Brk Msg Hndl
    JobStatMsgHndl           char(10);                                // Status Msg Hndl
    JobDevRcvActin           char(13);                                // Device Recov Act
    JobDDMCnvtHndl           char(10);                                // DDM Conv Hndl
    JobDateSeparat           char(1);                                 // Date Separator
    JobDateFmt               char(4);                                 // Date Format
    JobPrintText             char(30);                                // Print Text
    JobSubmJobName           char(10);                                // Subm Job Name
    JobSubmUserNam           char(10);                                // Subm User Name
    JobSubmJobNum            char(6);                                 // Subm Job Num
    JobSubmMsgQueu           char(10);                                // Subm Msgq Name
    JobSubmMsgLib            char(10);                                // Subm Msgq Lib
    JobTimeSeparat           char(1);                                 // Time Separator
      JobCodeCharSet            int(10:0);                            // Coded Char Set ID
    JobSchedDateTm           char(26);                                // Sched Date Time
    JobPrintKeyFmt           char(10);                                // Print Key Format
    JobSortSeq               char(10);                                // Sort Sequence
      JobsortSeqLib            char(10);                              // Sort Sequence Lib
    JobLangID                char(3);                                 // Language ID
    JobCountryID             char(2);                                 // Country ID
      JobCompStatus            char(1);                               // Completion Status
    JobSignedInJob           char(1);                                 // Signed On Job
    JobSwitches              char(8);                                 // Job Switches
   JobMsgqFullAct           char(10);                                /// Job Msgq Full Action
      JobMsgqMaxSize            int(10:0);                            // Job Msgq Max Size
   JobDegCodeChar            int(10:0);                              /// Default Coded Char S
    JobRoutingData           char(80);                                // Routing Data
    JobDeciamlFmt            char(1);                                 // Decimal Format
    JobCharIDCntl            char(10);                                // Chrid Ctl
    JobServerType            char(30);                                // Server Type
  end-pi;

  dcl-ds ds_jobIo100;                                                   // Qwc JOBI0400
    jobIo100.bytesReturned03                   int(10:0);                              // Bytes Return
    jobIo100.bytesAvailable03                   int(10:0);                              // Bytes Avail
    QUSJN06                  char(10);                                // Job Name
    QUSUN05                  char(10);                                // User Name
    QUSJNBR05                char(6);                                 // Job Number
    jobIo100.internalJobIdentifier03                char(16) inz;                            // Int Job ID
    QUSJS09                  char(10);                                // Job Status
    QUSJT06                  char(1);                                 // Job Type
    QUSJS10                  char(1);                                 // Job Subtype
    QUSDES                   char(13);                                // Date Enter Sys
    QUSDJA                   char(13);                                // Date Job Active
    QUSJAC                   char(15);                                // Job Acct Code
    QUSJDN                   char(10);                                // Job Desc Name
    QUSJDL                   char(10);                                // Job Desc Lib
    QUSUWID                  char(24);                                // Unit Work ID
    QUSMN06                  char(8);                                 // Mode Name
    QUSIMR                   char(10);                                // Inq Msg Reply
    QUSLCP                   char(10);                                // Log Cl Pgms
    QUSBMH                   char(10);                                // Brk Msg Hndl
    QUSSMH                   char(10);                                // Status Msg Hndl
    QUSDRA                   char(13);                                // Device Recov Act
    QUSDDMCH                 char(10);                                // DDM Conv Hndl
    QUSDS                    char(1);                                 // Date Separator
    QUSDF                    char(4);                                 // Date Format
    QUSPT                    char(30);                                // Print Text
    QUSSJN00                 char(10);                                // Subm Job Name
    QUSSUN00                 char(10);                                // Subm User Name
    QUSSJNBR00               char(6);                                 // Subm Job Num
    QUSSMN00                 char(10);                                // Subm Msgq Name
    QUSSML00                 char(10);                                // Subm Msgq Lib
    jobIo100.timeSlice01                  char(1);                                 // Time Separator
      QUSCCSID07                int(10:0);                            // Coded Char Set ID
    QUSSDT                   char(8);                                 // Sched Date Time
    QUSPKF                   char(10);                                // Print Key Format
    QUSSS03                  char(10);                                // Sort Sequence
      QUSSSL                   char(10);                              // Sort Sequence Lib
    QUSLID01                 char(3);                                 // Language ID
    QUSCID01                 char(2);                                 // Country ID
      QUSCS                    char(1);                               // Completion Status
    QUSSOJ00                 char(1);                                 // Signed On Job
    QUSJS11                  char(8);                                 // Job Switches
   QUSJMFA                  char(10);                                /// Job Msgq Full Action
    QUSRVED1                 char(1);                                 // Reserved1
      QUSJMMS                   int(10:0);                            // Job Msgq Max Size
   QUSDCCSI                  int(10:0);                              /// Default Coded Char S
    QUSRD03                  char(80);                                // Routing Data
    QUSDF00                  char(1);                                 // Decimal Format
    QUSCC05                  char(10);                                // Chrid Ctl
    QUSCsvr                  char(30);                                // Server Type
  end-ds;

  dcl-ds QUSErr                Len(116) inz;
    QUSBPRV                   int(10:0) inz(116);
    jobIo100.bytesAvailableVL                   int(10:0) inz(0);
    QUSEI                    char(7) inz;
    QUSERVED                 char(1) inz;
    QUSED01                  char(100) inz;
  end-ds;

  dcl-s FormatName            char(8) inz('JOBI0400');
  dcl-s ReceiveLen             int(10:0) inz(497);
  dcl-s JobNameFull           char(26) inz;
  dcl-s IntJobName            char(16) inz;

  %subst(JobNameFull:1:10) = JobName;
  %subst(JobNameFull:11:10) = JobUser;
  %subst(JobNameFull:21:6) = JobNumber;

// >>>>> Automatically removed by conversion
//C                   Call      'QUSRJOBI'

  callp QUSRJOBI(
                ds_jobIo100
                :ReceiveLen
                :FormatName
                :JobNameFull
                :IntJobName
                :QusErr
                );

//C                   Parm                    ds_jobIo100
//C                   Parm                    ReceiveLen
//C                   Parm                    FormatName
//C                   Parm                    JobNameFull
//C                   Parm                    IntJobName
//C                   Parm                    QusErr

  select;                                                             // -\
    when '0' = %subst(QUSDES:1:1);                                    // <I
      JobDateEntSys = '19';                                           //  I
    when '1' = %subst(QUSDES:1:1);                                    // <I
      JobDateEntSys = '20';                                           //  I
    when '2' = %subst(QUSDES:1:1);                                    // <I
      JobDateEntSys = '21';                                           //  I
    when '3' = %subst(QUSDES:1:1);                                    // <I
      JobDateEntSys = '22';                                           //  I
    other;                                                            // <I
      JobDateEntSys = '20';                                           //  I
  endsl;                                                              // -/

  JobDateEntSys = %trim(JobDateEntSys) +
  %subst(QUSDES:2:2) + '-' +
  %subst(QUSDES:4:2) + '-' +
  %subst(QUSDES:6:2) + '-' +
  %subst(QUSDES:8:2) + '.' +
  %subst(QUSDES:10:2) + '.' +
  %subst(QUSDES:12:2) + '.' + '000000';

  if QUSDJA <> *Blank;                                                // ---\
    select;                                                           // -\ I
      when '0' = %subst(QUSDJA:1:1);                                  // <I I
        JobDateJobAct = '19';                                         //  I I
      when '1' = %subst(QUSDJA:1:1);                                  // <I I
        JobDateJobAct = '20';                                         //  I I
      when '2' = %subst(QUSDJA:1:1);                                  // <I I
        JobDateJobAct = '21';                                         //  I I
      when '3' = %subst(QUSDJA:1:1);                                  // <I I
        JobDateJobAct = '22';                                         //  I I
      other;                                                          // <I I
        JobDateJobAct = '20';                                         //  I I
    endsl;                                                            // -/ I
//                                                                            I
    JobDateJobAct = %trim(JobDateJobAct) +                            //    I
    %subst(QUSDJA:2:2) + '-' +                                        //    I
    %subst(QUSDJA:4:2) + '-' +                                        //    I
    %subst(QUSDJA:6:2) + '-' +                                        //    I
    %subst(QUSDJA:8:2) + '.' +                                        //    I
    %subst(QUSDJA:10:2) + '.' +                                       //    I
    %subst(QUSDJA:12:2) + '.' + '000000';                             //    I
  endif;                                                              // ---/

  JobStatus      = QUSJS09;
//***************** Eval      JobDateEntSys  = QUSDES
//***************** Eval      JobDateJobAct  = QUSDJA
  JobAcctCose    = QUSJAC;
  JobDescName    = QUSJDN;
  JobDescLib     = QUSJDL;
  JobUnitWorkID  = QUSUWID;
  JobModeName    = QUSMN06;
  JobInqMshReply = QUSIMR;
  JobLogClPgms   = QUSLCP;
  JobBrkMsgHndl  = QUSBMH;
  JobStatMsgHndl = QUSSMH;
  JobDevRcvActin = QUSDRA;
  JobDDMCnvtHndl = QUSDDMCH;
  JobDateSeparat = QUSDS;
  JobDateFmt     = QUSDF;
  JobPrintText   = QUSPT;
  JobSubmJobName = QUSSJN00;
  JobSubmUserNam = QUSSUN00;
  JobSubmJobNum  = QUSSJNBR00;
  JobSubmMsgQueu = QUSSMN00;
  JobSubmMsgLib  = QUSSML00;
  JobTimeSeparat = jobIo100.timeSlice01;
  JobCodeCharSet = QUSCCSID07;
  JobSchedDateTm = QUSSDT;
  JobPrintKeyFmt = QUSPKF;
  JobSortSeq     = QUSSS03;
  JobsortSeqLib  = QUSSSL;
  JobLangID      = QUSLID01;
  JobCountryID   = QUSCID01;
  JobCompStatus  = QUSCS;
  JobSignedInJob = QUSSOJ00;
  JobSwitches    = QUSJS11;
  JobMsgqFullAct = QUSJMFA;
  JobMsgqMaxSize = QUSJMMS;
  JobDegCodeChar = QUSDCCSI;
  JobRoutingData = QUSRD03;
  JobDeciamlFmt  = QUSDF00;
  JobCharIDCntl  = QUSCC05;
  JobServerType  = QUSCsvr;

  return *Blank;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc GetJobInfo0500;
  dcl-pi GetJobInfo0500       char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char(6) value;
    JobStaus                 char(10);                                // Job Status
    JobType                  char(1);                                 // Job Type
    JobSubType               char(1);                                 // Job Subtype
    JobEndSeverity            int(10:0);                              // End Severity
    JobLogSeverity            int(10:0);                              // Log Severity
    JobLogLevel              char(1);                                 // Log Level
    JobLogText               char(10);                                // Log Text
  end-pi;

  dcl-ds ds_jobIo100;                                                   // Qwc JOBI0500
    jobIo100.bytesReturned04                   int(10:0);                              // Bytes Return
    jobIo100.bytesAvailable04                   int(10:0);                              // Bytes Avail
    QUSJN07                  char(10);                                // Job Name
    QUSUN06                  char(10);                                // User Name
    QUSJNBR06                char(6);                                 // Job Number
    jobIo100.internalJobIdentifier04                char(16) inz;                            // Int Job ID
    QUSJS12                  char(10);                                // Job Status
    QUSJT07                  char(1);                                 // Job Type
    QUSJS13                  char(1);                                 // Job Subtype
    QUSERVED30               char(2);                                 // Reserved
    QUSES                     int(10:0);                              // End Severity
    QUSLS                     int(10:0);                              // Log Severity
    QUSLL                    char(1);                                 // Log Level
    QUSLT                    char(10);                                // Log Text
  end-ds;

  dcl-ds QUSErr                Len(116) inz;
    QUSBPRV                   int(10:0) inz(83);
    jobIo100.bytesAvailableVL                   int(10:0) inz(0);
    QUSEI                    char(7) inz;
    QUSERVED                 char(1) inz;
    QUSED01                  char(100) inz;
  end-ds;

  dcl-s FormatName            char(8) inz('JOBI0500');
  dcl-s ReceiveLen             int(10:0) inz(307);
  dcl-s JobNameFull           char(26) inz;
  dcl-s IntJobName            char(16) inz;

  %subst(JobNameFull:1:10) = JobName;
  %subst(JobNameFull:11:10) = JobUser;
  %subst(JobNameFull:21:6) = JobNumber;

// >>>>> Automatically removed by conversion
//C                   Call      'QUSRJOBI'

  callp QUSRJOBI(
                ds_jobIo100
                :ReceiveLen
                :FormatName
                :JobNameFull
                :IntJobName
                :QusErr
                );

//C                   Parm                    ds_jobIo100
//C                   Parm                    ReceiveLen
//C                   Parm                    FormatName
//C                   Parm                    JobNameFull
//C                   Parm                    IntJobName
//C                   Parm                    QusErr

  JobStaus       = QUSJS12;
  JobType        = QUSJT07;
  JobSubType     = QUSJS13;
  JobEndSeverity = QUSES;
  JobLogSeverity = QUSLS;
  JobLogLevel    = QUSLL;
  JobLogText     = QUSLT;

  return *Blank;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc GetJobInfo0600;
  dcl-pi GetJobInfo0600       char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char(6) value;
    JobStatus                char(10);                                // Job Status
    JobType                  char(1);                                 // Job Type
    JobSubType               char(1);                                 // Job Subtype
    JobSwitch                char(8);                                 // Job Switch
    JobEndStatus             char(1);                                 // End Status
    JobSbsName               char(10);                                // Subsys Name
    JobSbsLib                char(10);                                // Subsys Lib
    JobCurrUsrPrf            char(10);                                // Curr Usrprf Name
    JobDbcsEnabled           char(1);                                 // Dbcs Enabled
    JobExitKey               char(1);                                 // Exit Key
    JobCancelKey             char(1);                                 // Cancel Key
    JobProdRetCode            int(10:0);                              // Product Return Code
    JobUsrRetCode             int(10:0);                              // User Return Code
    JobPrgRetCode             int(10:0);                              // Program Return Code
    JobSpecialEnv            char(10);                                // Special Environment
    JobDeviceName            char(10);                                // Device Name
     JobGrpPrfName            char(10);                               // Group Profile Name
    JobGrpPrfNam01           char(10);                                // Group profile names
    JobGrpPrfNam02           char(10);                                // Group profile names
    JobGrpPrfNam03           char(10);                                // Group profile names
    JobGrpPrfNam04           char(10);                                // Group profile names
    JobGrpPrfNam05           char(10);                                // Group profile names
    JobGrpPrfNam06           char(10);                                // Group profile names
    JobGrpPrfNam07           char(10);                                // Group profile names
    JobGrpPrfNam08           char(10);                                // Group profile names
    JobGrpPrfNam09           char(10);                                // Group profile names
    JobGrpPrfNam10           char(10);                                // Group profile names
    JobGrpPrfNam11           char(10);                                // Group profile names
    JobGrpPrfNam12           char(10);                                // Group profile names
    JobGrpPrfNam13           char(10);                                // Group profile names
    JobGrpPrfNam14           char(10);                                // Group profile names
    JobGrpPrfNam15           char(10);                                // Group profile names
    JobUserID                char(10);                                // Job User ID
    JobUserIDSetti           char(1);                                 // Job User ID Setting
  end-pi;

  dcl-ds ds_jobIo100;                                                   // Qwc JOBI0600
    jobIo100.bytesReturned05                   int(10:0);                              // Bytes Return
    jobIo100.bytesAvailable05                   int(10:0);                              // Bytes Avail
    QUSJN08                  char(10);                                // Job Name
    QUSUN07                  char(10);                                // User Name
    QUSJNBR07                char(6);                                 // Job Number
    jobIo100.internalJobIdentifier05                char(16) inz;                            // Int Job ID
    QUSJS14                  char(10);                                // Job Status
    QUSJT08                  char(1);                                 // Job Type
    QUSJS15                  char(1);                                 // Job Subtype
    QUSJS16                  char(8);                                 // Job Switch
    QUSES00                  char(1);                                 // End Status
    QUSSN00                  char(10);                                // Subsys Name
    QUSSL06                  char(10);                                // Subsys Lib
    QUSCUN                   char(10);                                // Curr Usrprf Name
    QUSDE                    char(1);                                 // Dbcs Enabled
    QUSEK                    char(1);                                 // Exit Key
    QUSCK00                  char(1);                                 // Cancel Key
    QUSPRC                    int(10:0);                              // Product Return Code
    QUSURC                    int(10:0);                              // User Return Code
    QUSPGMRC                  int(10:0);                              // Program Return Code
    QUSSE02                  char(10);                                // Special Environment
    QUSDN                    char(10);                                // Device Name
     QUSGPN                   char(10);                               // Group Profile Name
   QUSGRPNS                 char(10) Dim(15);                        /// Group profile names-
    QUSJUID                  char(10);                                // Job User ID
    QUSJUIDS                 char(1);                                 // Job User ID Setting
  end-ds;


  dcl-ds QUSErr                Len(116) inz;
    QUSBPRV                   int(10:0) inz(116);
    jobIo100.bytesAvailableVL                   int(10:0) inz(0);
    QUSEI                    char(7) inz;
    QUSERVED                 char(1) inz;
    QUSED01                  char(100) inz;
  end-ds;

  dcl-s FormatName            char(8) inz('JOBI0600');
  dcl-s ReceiveLen             int(10:0) inz(307);
  dcl-s JobNameFull           char(26) inz;
  dcl-s IntJobName            char(16) inz;

  %subst(JobNameFull:1:10) = JobName;
  %subst(JobNameFull:11:10) = JobUser;
  %subst(JobNameFull:21:6) = JobNumber;

// >>>>> Automatically removed by conversion
//C                   Call      'QUSRJOBI'

  callp QUSRJOBI(
                ds_jobIo100
                :ReceiveLen
                :FormatName
                :JobNameFull
                :IntJobName
                :QusErr
                );

//C                   Parm                    ds_jobIo100
//C                   Parm                    ReceiveLen
//C                   Parm                    FormatName
//C                   Parm                    JobNameFull
//C                   Parm                    IntJobName
//C                   Parm                    QusErr

  JobStatus      = QUSJS14;
  JobType        = QUSJT08;
  JobSubType     = QUSJS15;
  JobSwitch      = QUSJS16;
  JobEndStatus   = QUSES00;
  JobSbsName     = QUSSN00;
  JobSbsLib      = QUSSL06;
  JobCurrUsrPrf  = QUSCUN;
  JobDbcsEnabled = QUSDE;
  JobExitKey     = QUSEK;
  JobCancelKey   = QUSCK00;
  JobProdRetCode = QUSPRC;
  JobUsrRetCode  = QUSURC;
  JobPrgRetCode  = QUSPGMRC;
  JobSpecialEnv  = QUSSE02;
  JobDeviceName  = QUSDN;
  JobGrpPrfName  = QUSGPN;
  JobGrpPrfNam01 = QUSGRPNS(01);
  JobGrpPrfNam02 = QUSGRPNS(02);
  JobGrpPrfNam03 = QUSGRPNS(03);
  JobGrpPrfNam04 = QUSGRPNS(04);
  JobGrpPrfNam05 = QUSGRPNS(05);
  JobGrpPrfNam06 = QUSGRPNS(06);
  JobGrpPrfNam07 = QUSGRPNS(07);
  JobGrpPrfNam08 = QUSGRPNS(08);
  JobGrpPrfNam09 = QUSGRPNS(09);
  JobGrpPrfNam10 = QUSGRPNS(10);
  JobGrpPrfNam11 = QUSGRPNS(11);
  JobGrpPrfNam12 = QUSGRPNS(12);
  JobGrpPrfNam13 = QUSGRPNS(13);
  JobGrpPrfNam14 = QUSGRPNS(14);
  JobGrpPrfNam15 = QUSGRPNS(15);
  JobUserID      = QUSJUID;
  JobUserIDSetti = QUSJUIDS;

  return *Blank;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc GetJobInfo0700U;
  dcl-pi GetJobInfo0700U      char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char(6) value;
    Librarytoget            Zoned(3:0) value;
    #ofLibrarys             Zoned(3:0);
    LibName                  char(10);
  end-pi;

  dcl-ds QUSI0700;                                                    //  Qwc JOBI0700
    qBytesReturned            int(10:0);                              //  Bytes Return
    qBytesAvailbe             int(10:0);                              //  Bytes Avail
    qJobname                 char(10);                                //  Job Name
    qUserName                char(10);                                //  User Name
    qJobNumber               char(6);                                 //  Job Number
    qInJobID                 char(16) inz;                            //  Int Job ID
    qJobStatus               char(10);                                //  Job Status
    qJobType                 char(1);                                 //  Job Type
    qJobSubType              char(1);                                 //  Job Subtype
    qReserved                char(2);                                 //  Reserved
    q#ofLibsinSYS             int(10:0);                              //  Libs In Syslibl
    q#ofLibsinProd            int(10:0);                              //  Prod Libs
    q#ofLibsinCurr            int(10:0);                              //  Curr Libs
    q#ofLibsinUser            int(10:0);                              //  Libs In Usrlibl
    qBuffer1                 char(5000);
  end-ds;

/Copy QMiscCopy,Err100S_D

  dcl-s FormatName            char(8) inz('JOBI0700');
  dcl-s RcvLength              int(10:0) inz;
  dcl-s Start1                 int(10:0) inz;
  dcl-s JobNameFull           char(26) inz;
  dcl-s IntJobName            char(16) inz;

  %subst(JobNameFull: 1:10) = JobName;
  %subst(JobNameFull:11:10) = JobUser;
  %subst(JobNameFull:21: 6) = JobNumber;
  RcvLength = %len(QUSI0700);

// >>>>> Automatically removed by conversion
//C                   Call      'QUSRJOBI'

  callp QUSRJOBI(
                QUSI0700
                :RcvLength
                :FormatName
                :JobNameFull
                :IntJobName
                :Err100
                );

//C                   Parm                    QUSI0700
//C                   Parm                    RcvLength
//C                   Parm                    FormatName
//C                   Parm                    JobNameFull
//C                   Parm                    IntJobName
//C                   Parm                    Err100

  if ERR100EXPTID <> *Blank;                                          // -----\
    Librarytoget = 0;                                                 //      I
    #ofLibrarys  = 0;                                                 //      I
    Libname      = *Blank;                                            //      I
  else;                                                               // ----<I
    if Librarytoget > 0                        and                    // ---\ I
    Librarytoget <= q#ofLibsinUser;                                   //    I I
      if (q#ofLibsinSYS + q#ofLibsinProd +                            // -\ I I
      q#ofLibsinCurr + q#ofLibsinUser) <> 0;                          //  I I I
        #ofLibrarys = q#ofLibsinUser;                                 //  I I I
        Start1 = (q#ofLibsinSYS + q#ofLibsinProd +                    //  I I I
        q#ofLibsinCurr - 1 ) * 11;                                    //  I I I
        LibName = %subst(qBuffer1:Start1 +                            //  I I I
        (11 * Librarytoget)+1:10);                                    //  I I I
      endif;                                                          // -/ I I
    else;                                                             // --<I I
      Libname = *Blank;                                               //    I I
    endif;                                                            // ---/ I
  endif;                                                              // -----/
  return Err100ExptID;
end-proc;
 /endif // comment
/endif
