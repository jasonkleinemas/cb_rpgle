**Free
*n char(1 ) const; // Whether or not to show the Send a Message display before sending the message. If this parameter is used, one of the following values must be specified;
             // Y - Use the Send a Message display. This is the default.
             // N - Do not use the Send a Message display. This value must be specified if the program is running in a batch job.
*n char(20) const; // Qualified message queue name
             // '*LIBL     *CURLIB  '
*n char(4 ) const; // The type of names in the list. If this parameter is used, one of the following values must be specified:
             // *USR - The list of names contains only user profile names. *USR is the default.
             // *DSP - The list of names contains only display station names. This value may not be specified if the Show Send a Message display parameter is Y.