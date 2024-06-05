**FREE
//
// All the formats start with this Block
//
    bytesReturned          int(10) pos( 1); // 00	00	BINARY(4)	Number of bytes returned
    bytesAvailable         int(10) pos( 5); // 04	04	BINARY(4)	Number of bytes available
    jobName               char(10) pos( 9); // 08	08	CHAR(10)	Job name
    userName              char(10) pos(19); // 18	12	CHAR(10)	User name
    jobNumber             char( 6) pos(29); // 28	1C	CHAR(6)	  Job number
    internalJobIdentifier char(16) pos(35); // 34	22	CHAR(16)	Internal job identifier
    jobStatus             char(10) pos(51); // 50	32	CHAR(10)	Job status
    jobType               char( 1) pos(61); // 60	3C	CHAR(1)	  Job type
    jobSubtype            char( 1) pos(62); // 61	3D	CHAR(1)	  Job subtype
