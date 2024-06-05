**Free
*n char(10 ) const; // The type of message to send. The value you specify determines the default for the Message needs reply prompt on the Send a Message display.
              // N - *INFO - Informational. The message does not need a reply.
              // Y - *INQ  - Inquiry. The message needs a reply.
*n char(10 ) const; //The delivery mode of the message. The value you specify determines the default for the Interrupt user prompt on the Send a Message display
              // N - *BREAK  - Break message temporarily interrupts the work that the user is doing.
              // Y - *NORMAL - The message goes to the user profile or display station message queue.
*n char(490) const; // Message text
*n int (10 ) const; // Length of message text
*n char(10 ) const; // A list of 0 through 299 user profile or display station names to which the message is being sent. The list you specify is shown as the default on the Send a Message display.
              // User profile or display station names.
              // *ALL    - The message queues of all users.
              // *ALLACT - The message queues of all active users or display stations. 
              // *SYSOPR - The system operator's message queue, QSYSOPR.
*n int (10 ) const; // Number of user profile or display station names
*n int (10 ) ; // Whether the user pressed F10 (Send message) to send one or more messages from the Send a Message display. One of the following values is returned:
              // 0 - No messages were sent.
              // 1 - One or more messages were sent. If the Show Send a Message display parameter is N and the program completes without error, this will always be 1.
              // 2 - One or more messages were sent, but one or more of the names specified were not valid. If the Show Send a Message display parameter is Y or not specified, the user names will be displayed and validated before the message is sent; therefore, this value will not be used.
*n int (10) ; // The function that the user requested when exiting the Send a Message display. One of the following values is returned:
              // -4 - User pressed the Exit key (F3).
              // -8 - User pressed the Cancel key (F12).
              //  0 - Send a Message display was not used.
*n options(*varsize) like(dsApiError0100); // Error code