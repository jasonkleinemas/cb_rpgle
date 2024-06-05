**Free
/if not defined(buildSbmJobCmdBasic_p)
/define buildSbmJobCmdBasic_p

  dcl-proc buildSbmJobCmdBasic;
    dcl-pi *n varchar(500);                  // Real count is 479
      is_cmd                char(300) value; // CMD     Command To Run Job
      is_jobName            char(10 ) value; // JOB     Job Name
      is_jobDesc            char(10 ) value; // JOBD    Job Description
      is_jobDescLib         char(10 ) value; // JOBDLIB Job Description Lib
      is_jobQ               char(10 ) value; // JOBQ    Job Queue Name
      is_jobQLib            char(10 ) value; // JOBQLIB Job Queue Library
      is_jobPriorityOnJobQ  char(5  ) value; // JOBPTY  Job Priority On JObq
      is_jobPriorityOnOutQ  char(5  ) value; // OUTPTY  Job Priority On Outq
      is_printDev           char(10 ) value; // PRTDEV  Print Device
      is_outQ               char(10 ) value; // OUTQ    Out Queue Name
      is_outQLib            char(10 ) value; // OUTQLIB Out Queue Library
    end-pi;

    dcl-s rtnCmd varchar(500) inz('SBMJOB');

    if is_cmd <> *Blank;
      rtnCmd += ' CMD(' + %trim(is_cmd) + ')';
    endif;

    if is_jobName <> *Blank;
      rtnCmd += ' JOB(' + %trim(is_jobName) + ')';
    endif;

    select;
      when is_jobDesc <> *Blank And is_jobDescLib <> *Blank;
        rtnCmd += ' JOBD('  +  %trim(is_jobDescLib) + '/' + %trim(is_jobDesc) + ')';
      when is_jobDesc <> *Blank And is_jobDescLib  = *Blank;
        rtnCmd += ' JOBD('  + %trim(is_jobDesc) + ')';
      other;
    endsl;

    select;
      when is_jobQ <> *Blank And is_jobQLib <> *Blank;
        rtnCmd += ' JOBQ(' + %trim(is_jobQLib) + '/' + %trim(is_jobQ) + ')';
      when is_jobQ <> *Blank And is_jobQLib  = *Blank;
        rtnCmd += ' JOBQ(' +  %trim(is_jobQ) + ')';
      other;
    endsl;

    if is_jobPriorityOnJobQ <> *Blank;                                              
      rtnCmd += ' JOBPTY(' + %trim(is_jobPriorityOnJobQ) + ')';
    endif;

    if is_jobPriorityOnOutQ <> *Blank;
      rtnCmd += ' OUTPTY(' + %trim(is_jobPriorityOnOutQ) + ')';
    endif;

    if is_printDev <> *Blank;
      rtnCmd += ' PRTDEV(' +  %trim(is_printDev) + ')';
    endif;

    select;
      when is_outQ <> *Blank And is_outQLib <> *Blank;
        rtnCmd += ' OUTQ(' + %trim(is_outQLib) + '/' + %trim(is_outQ) + ')';
      when is_outQ <> *Blank And is_outQLib  = *Blank;
        rtnCmd += ' OUTQ(' + %trim(is_outQ) + ')';
      other;
    endsl;

    return rtnCmd;

  end-proc;

/endif
