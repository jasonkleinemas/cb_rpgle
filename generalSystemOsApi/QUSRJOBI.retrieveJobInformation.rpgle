**FREE
/if not defined(QUSRJOBI_retrieveJobInformation)
/define QUSRJOBI_retrieveJobInformation
//
//
//
  dcl-pr QUSRJOBI  extPgm('QUSRJOBI'); // Retrieve Job Information (QUSRJOBI) API
   *n                       char(500); // 1 Char(*)   Receiver variable	          Output
   *n                        int( 10); // 2 Binary(4) Length of receiver variable	Input
   *n                       char(  8); // 3 Char(8)	  Format name	                Input
   *n                       char( 26); // 4 Char(26)  Qualified job name	        Input
   *n                       char( 16); // 5 Char(16)	Internal job identifier	    Input
   *n            like(dsApiError0100);//           char( 30); // 6 Char(*)	  Error code	                I/O
  end-pr;
    
/endIf

