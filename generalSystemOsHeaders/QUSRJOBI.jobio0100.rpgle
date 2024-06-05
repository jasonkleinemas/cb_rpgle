**FREE
/if not defined(QUSRJOBI_dt_jobIo0100)
/define QUSRJOBI_dt_jobIo0100
  dcl-ds format_jobIo0100 len(500) qualified template; // Offset Dex Hex JOBI0100 Format
/copy ../cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0010.part.rpgle
/copy ../cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0100.part.rpgle
  end-ds;
/endif