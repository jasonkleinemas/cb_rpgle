**FREE
/if not defined(QWCRJBST_retrieveJobStatus)
/define QWCRJBST_retrieveJobStatus

  dcl-pr QWCRJBST extPgm('QWCRJBST'); // Retrieve Job Status (QWCRJBST)
    *n                      char(60); // Receiver variable
    *n                   binDec(4:0); // Length of receiver variable
    *n                      char(26); // Job identifier
    *n                      char( 8); // Format of job identifier
    *n          like(dsApiError0100); // Error code
  end-pr;
//
//Receiver variable
//OUTPUT; CHAR(*)
//The receiver variable that receives the information requested. You can specify the size of the area to be smaller than the format requested as long as you specify the length parameter correctly. As a result, the API returns only the data that the area can hold.
//
//Length of receiver variable
//INPUT BINARY(4)
//The length of the receiver variable provided. The length of receiver variable parameter may be specified up to the size of the receiver variable specified in the user program. If the length of receiver variable parameter specified is larger than the allocated size of the receiver variable specified in the user program, the results are not predictable. The minimum length is 8 bytes.
//
//Job identifier
//INPUT CHAR(*)
//The identifier of the job for which the information is to be retrieved. The job can be identified in one of three ways: job number only, internal job number, or fully qualified job name. The next parameter specifies which format of job identifier is being used.
//
//Format of job identifier
//INPUT CHAR(8)
//The format of the job identifier being provided. The format names that can be used are as follows:
//
//JOBS0100	The job identifier is a 6-character job number. It is possible that more than one job may have the same job number. This API returns the requested information for only the first job that has the specified job number. No indication is returned to show if more than one job has the same job number.
//JOBS0200	The job identifier is a 16-character internal job number. The internal job number is obtained through the List Job (QUSLJOB) API or as output to this API.
//JOBS0300	The job identifier is a 26-character fully qualified job name.
//
//
//Format of Returned Information
//The information returned from this API has the following format:
//
// Offset  Type       Field
// Dec Hex
//  0	  0	 Binary(4)	Bytes returned
//  4	  4	 Binary(4)	Bytes available
//  8	  8	 CHAR(10)	  Job status
// 18	 12	 CHAR(16)	  Internal job identifier
// 34	 22	 CHAR(26)	  Fully qualified job name
// 
/endIf

