**Free
/if not defined(QUILNGTX)
/define QUILNGTX
//
// Requires:
// /copy ../cb_rpgle/generalSystemOsHeaders/apiFormatERRC0100.rpgle
//
// +---------------------------------------------------------------+
// | Display String of Data in Popup IBM i Window +
// +---------------------------------------------------------------+
// The Display Long Text (QUILNGTX) API displays a pop-up window containing
// the string of text that is passed to it.
// This API not be used to display text that is bidirectional right2left.
//
// Required Parameter Group
// Text string
//   INPUT; CHAR(*)
//   The text string that is to be displayed in a pop-up window.
// Length of text string
//   INPUT; BINARY(4)
//   The length of the text string, in bytes. The value must be greater
//   than zero and less than or equal to 15 728 640.
// Message ID
//   INPUT; CHAR(7)
//   The specified message ID of the panel title text that will be retrieved.
//
// If the message ID is not found in the specified message file, the message
// ID will be displayed at the top of the panel as the title. If the message
// ID is blank, the title for the panel is blank.
// Qualified message file name
//   INPUT; CHAR(20)
// Error code
//   I/O; CHAR(*)
//
// Error Messages
// Message ID Error Message Text
// CPF3C90 E Literal value cannot be changed
// CPF6A4C E At least one parameter value is not correct. Reason code is &1
// CPF9871 E Error occurred while processing

    dcl-pr QUILNGTX extpgm;
      *n char(8192) const; // MsgText
      *n int (10)   const; // MsgLength
      *n char(7 )   const; // MessageId
      *n char(21)   const; // MessageFile
      *n options(*omit:*varsize) like(dsApiError0100); // ErrorDS
    end-pr;

/endif
