**Free
*n int(10) const; // The coded character set identifier (CCSID) that the immediate message text is in. The following values are allowed:
            // 0	The immediate message text is assumed in the CCSID of the job running this API. This is the default value if this parameter is not specified
            // 65535	The immediate message text will not be converted.
            // CCSID	Specify a valid CCSID that your immediate message is in. Valid values are between 1 and 65535. This API will validate the CCSID.