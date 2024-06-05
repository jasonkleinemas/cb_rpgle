**FREE
    timeSliceEndPool            char(10) pos( 87); // 086	56	CHAR(10)	Time-slice end pool
    processingUnitTime           int(10) pos( 97); // 096	60	BINARY(4)	Processing unit time used, if less than 2,147,483,647 milliseconds
    systemPoolIdentifier         int(10) pos(101); // 100	64	BINARY(4)	System pool identifier
    MaxProcessingUnitTimeAllowed int(10) pos(105); // 104	68	BINARY(4)	Maximum processing unit time allowed
    tempStorageUsedKB            int(10) pos(109); // 108	6C	BINARY(4)	Temporary storage used, in kilobytes, if less than 2,147,483,647
    maxTempStoreageUsedKB        int(10) pos(113); // 112	70	BINARY(4)	Maximum temporary storage allowed, in kilobytes, if less than 2,147,483,647
    threadCount                  int(10) pos(117); // 116	74	BINARY(4)	Thread count
    maximumThreads               int(10) pos(121); // 120	78	BINARY(4)	Maximum threads
    tempStorageUsedMB            int(10) pos(125); // 124	7C	BINARY(4) UNSIGNED	Temporary storage used, in megabytes
    maxTempStoreageUsedMB        int(10) pos(129); // 128	80	BINARY(4)	Maximum temporary storage, in megabytes
    peakTempStoreageUsedMB       int(10) pos(133); // 132	84	BINARY(4) UNSIGNED	Peak temporary storage used, in megabytes
    processingUnitTimeUsed       int(20) pos(137); // 136	88	BINARY(8) UNSIGNED	Processing unit time used - total for the job