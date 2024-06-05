**FREE
//#----------------------------------------------------------------------------
//
//  https://www.ibm.com/docs/en/i/7.5?topic=exceptionerrors-program-status-data-structure
//
//#----------------------------------------------------------------------------
dcl-ds pgmPsds psds              qualified ;
  procedureName          char(10) pos(  1); // 001-010 Module or main procedure name. If the module was compiled with CRTRPGMOD, this is the name of the module that was created; if the program was created using CRTBNDRPG, this is the name of the program that was created. For a cycle-main module, this is the name of the main procedure.
  statusCode            zoned( 5) pos( 11); // 011-015 Status code.
  previousStatusCode    zoned( 5) pos( 16); // 016-020 Previous status code.
  sourceLineNumber       char( 8) pos( 21); // 021-028 Source line number. RPG IV source listing line number or statement number. The source listing line number is replaced by the source listing statement number if OPTION(*SRCSTMT) is specified instead of OPTION(*NOSRCSTMT). The full statement number is included when it applies to the root source member. If the statement number is greater than 6 digits (that is, it includes a source ID other than zero), the first 2 positions of the 8-byte feedback area will have a "+ " indicating that the rest of statement number is stored in positions 354-355.
  routineName            char( 8) pos( 29); // 029-036 Name of the RPG IV routine in which the exception or error occurred. This subfield is updated at the beginning of an RPG IV routine or after a program call only when the *STATUS subfield is updated with a nonzero value. The following names identify the routines:
                                   // *INIT Program initialization
                                   // *DETL Detail lines
                                   // *GETIN  Get input record
                                   // *TOTC Total calculations
                                   // *TOTL Total lines
                                   // *DETC Detail calculations
                                   // *OFL  Overflow lines
                                   // *TERM Program ending
                                   // *ROUTINE  Name of program or procedure called (first 8 characters).
                                   // Note: *ROUTINE is not valid unless you use the normal RPG IV cycle. Logic that takes the program out of the normal RPG IV cycle may cause *ROUTINE to reflect an incorrect value.
  numberOfParms        zoned( 3) pos( 37); // 037-039 Number of parameters passed to this program from a calling program. The value is the same as that returned by %PARMS. If no information is available, -1 is returned.
  exceptionType         char( 3) pos( 40); // 040-042 Exception type (CPF for an operating system exception or MCH for a machine exception).
  exceptionNumber       char( 4) pos( 43); // 043-046 Exception number. For a CPF exception, this field contains a CPF message number. For a machine exception, it contains a machine exception number.
  exception             char( 7) samepos(ExceptionType) ;
//reserved1             char( 4) pos( 47); // 047-050 Reserved
  msgWrkArea            char(30) pos( 51); // 051-080 Work area for messages. This area is only meant for internal use by the ILE RPG compiler. The organization of information will not always be consistent. It can be displayed by the user.
  programLib            char(10) pos( 81); // 081-090 Name of library in which the program is located.
  exceptionData         char(80) pos( 91); // 091-170 etrieved exception data. The message causing the error is placed in this subfield.
  exception9001Id       char( 4) pos(171); // 171-174 Identification of the exception that caused RNX9001 exception to be signaled.
  lastFileOperation1    char(10) pos(175); // 175-184 Name of file on which the last file operation occurred (updated only when an error occurs). This information always contains the full file name.
  unused1               char( 6) pos(185); // 185-190 Unused
  jobEnteredDate        char( 8) pos(191); // 191-198 Date (*DATE format) the job entered the system. In the case of batch jobs submitted for overnight processing, those that run after midnight will carry the next day's date. This value is derived from the job date, with the year expanded to the full four years. The date represented by this value is the same date represented by positions 270 - 275.
  jobEnteredCentury    zoned( 2) pos(199); // 199-200 First 2 digits of a 4-digit year. The same as the first 2 digits of *YEAR. This field applies to the century part of the date in positions 270 to 275. For example, for the date 1999-06-27, UDATE would be 990627, and this century field would be 19. The value in this field in conjunction with the value in positions 270 - 275 has the combined information of the value in positions 191 -198. Note: This century field does not apply to the dates in positions 276 to 281, or positions 288 to 293.
  lastFileOperation2    char( 8) pos(201); // 201-208 Name of file on which the last file operation occurred (updated only when an error occurs). This file name will be truncated if a long file name is used. See positions 175-184 for long file name information.
  lastFileStatus        char(35) pos(209); // 209-243 Status information on the last file used. This information includes the status code, the RPG IV opcode, the RPG IV routine name, the source listing line number or statement number, and record name. It is updated only when an error occurs. Note: The opcode name is in the same form as *OPCODE in the INFDS The source listing line number is replaced by the source listing statement number if OPTION(*SRCSTMT) is specified instead of OPTION(*NOSRCSTMT). The full statement number is included when it applies to the root source member. If the statement number is greater than 6 digits (that is, it includes a source ID other than zero), the first 2 positions of the 8-byte feedback area will have a "+ " indicating that the rest of statement number is stored in positions 356-357.
  jobName               char(10) pos(244); // 244-253 Job name.
  jobUser               char(10) pos(254); // 254-263 User name from the user profile.
  jobNumber            zoned( 6) pos(264); // 264-269 Job number.
  jobStartDate         zoned( 6) pos(270); // 270-275 Date (in UDATE format) the program started running in the system (UDATE is derived from this date). See User Date Special Words for a description of UDATE. This is commonly known as the 'job date'. The date represented by this value is the same date represented by positions 191 - 198.
  programDate          zoned( 6) pos(276); // 276-281 Date of program running (the system date in UDATE format). If the year part of this value is between 40 and 99, the date is between 1940 and 1999. Otherwise the date is between 2000 and 2039. The 'century' value in positions 199 - 200 does not apply to this field.
  programTime          zoned( 6) pos(282); // 282-287 Time (in the format hhmmss) of the program running.
  compileDate           char( 6) pos(288); // 288-293 Date (in UDATE format) the program was compiled. If the year part of this value is between 40 and 99, the date is between 1940 and 1999. Otherwise the date is between 2000 and 2039. The 'century' value in positions 199 - 200 does not apply to this field.
  compileTime           char( 6) pos(294); // 294-299 Time (in the format hhmmss) the program was compiled.
  compilerLevel         char( 4) pos(300); // 300-303 Level of the compiler.
  sourceFile            char(10) pos(304); // 304-313 Source file name.
  sourceLib             char(10) pos(314); // 314-323 Source file library.
  sourceMbr             char(10) pos(324); // 324-333 Source member name.
  programProcedure      char(10) pos(334); // 334-353 Program containing procedure.
  ModuleProcedure       char(10) pos(354); // 354-355 Module containing procedure.
  sourceLineNumberBin bindec( 2) pos(354); // 354-355 Source Id matching the statement number from positions 021-028. sourceLineNumber
  lastFileStatusBin   bindec( 2) pos(356); // 356-357 Source Id matching the statement number from positions 228-235. lastFileStatus
  curUserProfileName    char(10) pos(358); // 358-367 	Current user profile name.
  externalErrCode        int(10) pos(368); // 368-371 External error code.
  intoElements           int(20) pos(372); // 372-379 Elements set by XML-INTO or DATA-INTO.
  internalJobId         char(16) pos(380); // 380-395 Internal job id.
  systemName            char( 8) pos(396); // 396-403 System name.
end-ds;
