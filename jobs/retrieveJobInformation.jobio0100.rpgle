**FREE
/if not defined(QUSRJOBI_dt_jobIo0100)
//
// Copy book needed.
//
// /copy ../cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0100.rpgle
//======>  aaaaaa
/endif

/if not defined(getJobInfo0100)
/define getJobInfo0100

dcl-proc getJobInfo0100;
  dcl-pi *n       char(7);
    JobName                  char(10) value;
    JobUser                  char(10) value;
    JobNumber                char( 6) value;
    od_jobInfo             likeds(format_jobIo0100);
  end-pi;

/copy ../cb_rpgle/generalSystemOsApi/QUSRJOBI.retrieveJobInformation.rpgle

  dcl-ds apiErr likeds(dsApiError0100);

  dcl-ds fullJobName len(26) qualified;
    jobName              like(JobName);
    jobUser              like(JobUser);
    jobNumber          like(JobNumber);
  end-ds;

  dcl-s formatName            char( 8) inz('JOBI0100');
  dcl-s receiveLen             int(10) inz(500);
  dcl-s internalJobName       char(16);

  fullJobName.jobName   = JobName;
  fullJobName.jobUser   = JobUser;
  fullJobName.jobNumber = JobNumber;

  callp QUSRJOBI(od_jobInfo : receiveLen : formatName : fullJobName : internalJobName : apiErr );

  return *Blank;
end-proc;
/endIf