**FREE
/if not defined(QUSRJOBI_dt_jobIo0150)
/define QUSRJOBI_dt_jobIo0150
  dcl-ds format_jobIo0150 len(500) qualified template; // Offset Dex Hex JOBI0150 Format
/copy ../cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0010.part.rpgle
/copy ../cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0100.part.rpgle
/copy ../cb_rpgle/generalSystemOsHeaders/QUSRJOBI.jobio0150.part.rpgle
  end-ds;
/endIf