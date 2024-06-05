**FREE
/if not defined(getJobStatus)
/define getJobStatus

dcl-proc getJobStatus;
  dcl-pi *n              char( 10);
    JobName              char( 10) value;
    JobUser              char( 10) value;
    JobNumber            char(  6) value;
  end-pi;

/copy ../cb_rpgle/generalSystemOsApi/QWCRJBST.retrieveJobStatus.rpgle

  dcl-ds fullJobName len(26) qualified;
    jobName              like(JobName);
    jobUser              like(JobUser);
    jobNumber            like(JobNumber);
  end-ds;
  
  dcl-ds myErr likeds(dsApiError0100);

  dcl-s JobStatString    char( 60);
  dcl-s JobLengthRcv   binDec(4:0) inz(60);  
  dcl-s JobRetFmt        char(  8) inz('JOBS0300');

  fullJobName.jobName   = JobName;
  fullJobName.jobUser   = JobUser;
  fullJobName.jobNumber = JobNumber;

  callp QWCRJBST(JobStatString:JobLengthRcv:fullJobName:JobRetFmt:myErr);

  return %subst(JobStatString:9:10);

end-proc;
/endIf

