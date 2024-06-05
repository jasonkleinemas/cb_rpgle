**FREE
//
// This needs to be split out
//
//
//
/if not defined(QDFRTVFD_retrieveDisplayFileDescription)
/define QDFRTVFD_retrieveDisplayFileDescription


//---------------------------------------------------------------*
//  Retrieve field location
//---------------------------------------------------------------*

dcl-proc RtvFldLoc;
  dcl-pi RtvFldLoc;
    is_FileName                 char(10) Value;
    is_FileLib                  char(10) Value;
    is_RcdFmt                   char(10) Value;
    is_FldNam                   char(10) Value;
    oi_Row                    packed(3:0);
    oi_Col                    packed(3:0);
  end-pi;

//  Retrieve display file description ( QDFRTVFD ) API

  dcl-pr QDFRTVFD   ExtPgm('QDFRTVFD');
   *n                 Like(RcvVar);    // 1	Receiver variable	          Output  char(*)      
   *n                 Like(RcvVarLen); // 2	Length of receiver variable	Input   Binary(4)
   *n                 char(8);         // 3	Format name	                Input	  char(8)
   *n                 char(20);        // 4	Qualified file name	        Input   char(20)
   *n                 Like(ApiErrDs);  // 5	Error code	                Output  char(*)
  end-pr;                                        

  dcl-ds ApiErrDs                 Inz;
    ApiErrSiz                 int(10:0) Inz( 272 );
    ApiErrLen                 int(10:0);
    ApiErrID                 char(7);
    *n                       char(1);
    ApiErrTxt                char(256);
  end-ds;

  dcl-s RcvVar                char(32767);
  dcl-s RcvVarLen              int(10:0) Inz( %Size( RcvVar ) );
  dcl-s Idx                    int(10:0);
  dcl-s SDFFINFO               int(10:0);
  dcl-s LDFARFTE               int(10:0);
  dcl-s SDFARFTE               int(10:0);
  dcl-s SDFFRDPD               int(10:0);
  dcl-s SDFFRCTE               int(10:0);
  dcl-s SDFFXRDP               int(10:0);
  dcl-s SDFFRINF               int(10:0);
  dcl-s SDFFNTB                int(10:0);
  dcl-c TRUE                   *on;
  dcl-c FALSE                  *off;

  dcl-s dspfRecAtrbutes char(16) dim( 50);
  dcl-s dspfRecNames    char(10) dim( 50);
  dcl-s dspfFieldNames           char(10) dim(999);
  dcl-s FLDRC           char( 2) dim(999);

  dcl-ds *n;
    RC12                      int(5:0);
    RC1                      char(1) Overlay( RC12:1 );
    RC2                      char(1) Overlay( RC12:2 );
  end-ds;

//
//  Base file section ( QDFFBASE )
//
  dcl-c  bfs_length                  const(20);
  dcl-ds bfs         len(bfs_length) qualified; // Offset Dec QDFFBASE Base file section
    retDataLen             binDec(8:0) pos(1) ; // 00 WDFFRETN Length of the returned data.
    sizeDfd                binDec(8:0) pos(5) ; // 04 WDFFSIZE Size of the display file description.
    offset_fhs             binDec(4:0) pos(9) ; // 08 WDFFINOF Displacement to file header section see structure QDFFINFO
    numberOfRecords        binDec(4:0) pos(11); // 10 WDFFRCS Number of record formats specified. This number includes internally generated record formats.
//  QDFBITS                  char(1)   pos(13); // 12 WDFFDPAT Display attribute bits.
//  WDFFSEPI                                    // 12 WDFFSEPI Bit(0)(1) If on, INDARA keyword is specified.
//  WDFFDESF                                    // 12 WDFFDESF Bit(1)(1) 	If on, ERRSFL keyword is specified. Note: The ERRSFL keyword generates additional internal records (*ERRSFL).
//  Reserved                                    // 12 Reserved Bit(2)(6)
    QDFFFSCR               binDec(4:0) pos(14); // 13 Number of valid file screen sizes (see structure QDFFSCR
    offset_sst             binDec(4:0) pos(16); // 15 Displacement to sort sequence table (see structure QDFFSSEQ
    QDFCCSID               binDec(4:0) pos(18); // 17 CCSID of source member used to create the device file.
    QDFFSCRS                 char(1)   pos(20); // 19 Screen size table. This area defines the screen sizes valid for externally defined files. This is specified by the DSPSIZ keyword. When not specified, a default DSPSIZ(*DS3) is generated. Structure QDFFSCRA (Screen Size Table (QDFFSCRA)) defines the entries. The elements are in the sequence that the DSPSIZ keywords are specified.
  end-ds;
//
//  Sort Sequence Table (QDFFSSEQ)
//  
  dcl-c  sst_len                     const(294);
  dcl-ds sst             len(sst_len) qualified; // Offset Dec QDFFSSEQ Sort Sequence Table
    WDFFSST                  char(256) pos(  1); // 000 WDFFSST	 Sort sequence table.
    WDFFSSC                binDec(2:0) pos(255); // 256	WDFFSSC	 CCSID associated with the table.
    nameTable                 char(10) pos(257); // 258	WDFFSSN	 Table name.
    nameLibrary               char(10) pos(267); // 268	WDFFSSL	 Library name.
    WDFFSSFL                  char( 2) pos(277); // 278	WDFFSSFL Indicator flags.
//  WDFFSSUS                                     // 278	WDFFSSUS Bit(0)(1) Weighted indicator. 0 is defined as shared weighted; 1 is defined as unique weighted.
//  WDFFSSSB                                     // 278	WDFFSSSB Bit(1)(1) Substitution characters indicator. 0 is defined as having no substitution characters; 1 is defined as having substitution characters.
//  Reserved                                     // 278 Reserved Bit(2)(14)	
    Reserved                  char(16) pos(279); // 280	Reserved
  end-ds;
//
//  File header section ( QDFFINFO )
//
  dcl-c  fhs_length                  const(36);
  dcl-ds fhs         len(fhs_length) qualified; // Offset Dec QDFFINFO File header section
    headerLen              binDec(8:0) pos(1);  // 00 WDFFDFLO Length of the file header section. This includes the display-file-level device-dependent section. This is also the displacement from structure QDFFINFO to the record format table (see structure QDFARFTE
//  QDFFWUOF               binDec(8:0) pos(5);  // 04 WDFFWUOF Displacement to the where-used file-level information structure from structure QDFFINFO (see structure QDFWFLEI
//  QDFFFMWU               binDec(8:0) pos(9);  // 08 WDFFFMWU Length of file header section and the where-used file-level information structure.
//  QDFFSEQO               binDec(8:0) pos(13); // 12 WDFFSEQO Displacement from structure QDFFINFO to the sequence number table defined by structure QDFFSEQT
//  QDFFFSFL               binDec(4:0) pos(17); // 16 WDFFSFL  Maximum number of entries in the selection tables defined by structure QDFFSTBL
//  QDFFFSCE               binDec(4:0) pos(19); // 18 WDFFSCE  Maximum number of entries in the selection tables for this file (structure QDFFSTBL
//  QDFBITS01                char(2)   pos(21); // 20 WDFFFFLG File level flag.
//  Reserved                                    // 20 Reserved Bit(0)(1)
//  WDFFGRPH                                    // 20 WDFFGRPH Bit(1)(1) If on, the file contains at least one field with a graphic (G) data type.
//  Reserved                                    // 20 Reserved Bit(2)(14)
//  Reserved                 char(12)  pos(23); // 22 Reserved
//  QDFFXDOF               binDec(4:0) pos(35); // 34 WDFFXDOF Displacement to display-file-level device-dependent section from structure QDFFINFO (see structure QDFFDPDD
  end-ds;
//
//  Record format table ( QDFARFTE )
//
  dcl-c  rft_length                  const(16);
  dcl-ds rft         len(rft_length) qualified; // Offset Dec QDFARFTE  Record format table
    recName                  char(10)  pos(1) ; // 00 WDFARFNM Record format name. Names that begin with * are internally generated record formats.
//  QDFBITS08                char(2)   pos(11); // 10 WDFARCND Miscellaneous record contents.
//  WDFFRECD                                    // 10 WDFFRECD Bit(0)(1) If on, RECID keyword specified on this format.
//  Reseved                                     // 10 Reserved Bit(1)(15)
    offset_rhs             binDec(8:0) pos(13); // 12 WDFARFOF Displacement to the record header section (see structure QDFFRINF
  end-ds;
//
//  Record header section ( QDFFRINF )
//
  dcl-c  rhs_length                  const(30);
  dcl-ds rhs         len(rhs_length) qualified; // Offset Dec QDFFRINF Record header section
    QDFFRDDO               binDec(8:0) pos(1) ; // 00 WDFFRDDO Length of the record header section. This length includes the device-dependent sections (that is, it is the displacement to structure QDFFFINF for the first field in that record format).
    QDFFOFIT               binDec(8:0) pos(5) ; // 04 WDFFOFIT The displacement from structure QDFFRINF to the field indexing table defined by structure QDFFFITB 
    QDFFSTBO               binDec(8:0) pos(9) ; // 08 WDFFSTBO The displacement from structure QDFFRINF to the selection table defined by structure QDFFSELT 
//  QDFBITS09                char(4)   pos(13); // 12 WDFFRFLG Miscellaneous record contents.
//  WDFFUDDS                                    // 12 WDFFUDDS Bit(0)(1) If on, USRDFN keyword is specified.
//  WDFFSFL                                     // 12 WDFFSFL  Bit(1)(1) If on, SFL keyword is specified (next record is SFLCTL).
//  WDFFSFLC                                    // 12 WDFFSFLC Bit(2)(1) If on, SFLCTL keyword is specified (previous record is SFL).
//  WDFFMSGR                                    // 12 WDFFMSGR Bit(3)(1) If on, SFLMSGRCD keyword is specified.
//  WDFFRICV                                    // 12 WDFFRICV Bit(4)(1) If on, IGCCNV record is specified. Note: The IGCCNV keyword generates additional internal records.
//  Reserved                                    // 12 Reserved Bit(5)(3) 
//  WDFFALLH                                    // 13 WDFFALLH Bit(0)(1) If on, DBCS data that can be processed is specified in record. This occurs when the O, J, or E data type is specified; when DBCS literals are specified on a DFT, DFTVAL, SFLMSG, RECID, ERRMSG, or RTGCON keyword.
//  Reserved                                    // 13 Reserved Bit(1)(1) 
//  WDFFREXC                                    // 13 WDFFREXC Bit(2)(1) If on, DBCS data that can be processed is specified in record. This occurs when the O, J, or E data type is specified; when DBCS literals are specified on a DFT, DFTVAL, SFLMSG, RECID, ERRMSG, or RTGCON keyword.
//  WDFFRIDV                                    // 13 WDFFRIDV Bit(3)(1) If on, format requires a DBCS device.
//  WDFFREXT                                    // 13 WDFFREXT Bit(4)(1) If on, extractable DBCS data is in format.
//  WDFFRALT                                    // 13 WDFFRALT Bit(5)(1) If on, at least one field in format was specified as IGCALTTYP.
//  WDFFMEMF                                    // 13 WDFFMEMF Bit(6)(1) If on, CHECK(ME) or CHECK(MF) specified in at least one field in record.
//  WDFFNDLC                                    // 13 WDFFNDLC Bit(7)(1) If on, ALWENDLOC keyword is specified in record.
//  WDFFRGPH                                    // 14 WDFFRGPH Bit(0)(1) If on, graphic fields are specified in record.
//  WDFFRCL                                     // 14 WDFFRCL  Bit(1)(1) If on, RTNCSRLOC keyword is specified in record.
//  WDFFMBAR                                    // 14 WDFFMBAR Bit(2)(1) If on, MNUBAR keyword is specified in record.
//  WDFFPULL                                    // 14 WDFFPULL Bit(3)(1) If on, PULLDOWN keyword is specified in record.
//  WDFFPLSI                                    // 14 WDFFPLSI Bit(4)(1) Selection indicators on PULLDOWN keyword. 0 is defined as *NOSLTIND; 1 is defined as *SLTIND (default).
//  WDFFFCPF                                    // 14 WDFFFCPF Bit(5)(1) If on, FLDCSRPRG specified on field in record.
//  WDFFCNTMCFFLD                          // 14 WDFFCNTMCFFLD Bit(6)(1) If on, CNTFLD, MLTCHCFLD, or SNGCHCFLD keyword is specified on a field within this record.
//  WDFFEDTMSK                                // 14 WDFFEDTMSK Bit(7)(1) If on, EDTMSK keyword is specified in record.
//  WDFFGRIDREC                              // 15 WDFFGRIDREC Bit(0)(1) If on, GRDRCD keyword is specified in record.
//  Reserved                                    // 15 Reserved Bit(1)(7)
    numOfRec               binDec(4:0) pos(17); // 16 WDFFFLD Number of fields in this record.
//  Reserved                 char(4)   pos(19); // 18 Reserved
    QDFFINDO               binDec(4:0) pos(23); // 22 WDFFINDO If INDARA keyword is specified and response indicators are in this record, this is the displacement from structure QDFFRINF to the response indicator keyword array (see structure QDFKMSCP, Response Indicator Keyword Array (QDFKMSCP)) in category 4. 0 means the INDARA keyword is not specified or if INDARA is specified, there are no response indicators.
//  Reserved                 char(4)   pos(25); // 24 Reserved
    offset_drldds          binDec(4:0) pos(29); // 28 WDFFRAOF Displacements to display-record-level device-dependent section and subfile control record from structure QDFFRINF (see structures QDFFRDPD, Display-Record-Level Device-Dependent Section (QDFFRDPD), and QDFFSFCR, Subfile Control Record (QDFFSFCR)).
  end-ds;
//
//  Display-Record-Level-Device-Dependent section ( QDFFRDPD )
//
  dcl-c  drldds_len                  const(34);
  dcl-ds drldds      len(drldds_len) qualified; // Offset Dec QDFFRDPD Display-Record-Level-Device-Dependent section
    offset_rct             binDec(8:0) pos(1) ; // 00 WDFFDRCO Displacement to first row-column table (QDFFRCTB) from structure QDFFRINF. One row-column table exists for each display size (see variable WDFFSCR in structure QDFFBASE). The following may be used to access the correct table: let n = index into screen size array QDFFSCRA. (WDFFDRCO + (n - 1) * (WDFFFLD * LENGTH(WDFFRC)) + LENGTH(WDFFFRTO) ) from QDFFRINF.
    QDFFINCP               binDec(4:0) pos(5) ; // 04 WDFFINCP Number of input-capable fields (that is, total input, both, and hidden).
    QDFFFIBF               binDec(4:0) pos(7) ; // 06 WDFFIBF Number of input and both fields.
    QDFFFOIS               binDec(4:0) pos(9) ; // 08 WDFFOIS Number of option indicators.
//  Reserved                 char(2)   pos(11); // 10 Reserved
//  WDFACKYS                 char(4)   pos(12)  // 11 Indicates if a CA or CF key is specified. To determine which key (CA or CF) is specified, check the corresponding WDFFCKnn bit in structure QDFFDPDD
//  WDFACKY1                 char(1)   pos(12)  // 11 Keys 1 through 8 without option indicators.
//  WDFACK1                                     // 11  Bit(0)(1) If on, CA/CF key 1 is specified.
//  WDFACK2                                     // 11  Bit(1)(1) If on, CA/CF key 2 is specified.
//  WDFACK3                                     // 11  Bit(2)(1) If on, CA/CF key 3 is specified.
//  WDFACK4                                     // 11  Bit(3)(1) If on, CA/CF key 4 is specified.
//  WDFACK5                                     // 11  Bit(4)(1) If on, CA/CF key 5 is specified.
//  WDFACK6                                     // 11  Bit(5)(1) If on, CA/CF key 6 is specified.
//  WDFACK7                                     // 11  Bit(6)(1) If on, CA/CF key 7 is specified.
//  WDFACK8                                     // 11  Bit(7)(1) If on, CA/CF key 8 is specified.
//  WDFACKY2                 char(1)   pos(13)  // 12 Keys 9 through 16 without option indicators.
//  WDFACK9                                     // 12  Bit(0)(1) If on, CA/CF key 9 is specified.
//  WDFACK10                                    // 12  Bit(1)(1) If on, CA/CF key 10 is specified.
//  WDFACK11                                    // 12  Bit(2)(1) If on, CA/CF key 11 is specified.
//  WDFACK12                                    // 12  Bit(3)(1) If on, CA/CF key 12 is specified.
//  WDFACK13                                    // 12  Bit(4)(1) If on, CA/CF key 13 is specified.
//  WDFACK14                                    // 12  Bit(5)(1) If on, CA/CF key 14 is specified.
//  WDFACK15                                    // 12  Bit(6)(1) If on, CA/CF key 15 is specified.
//  WDFACK16                                    // 12  Bit(7)(1) If on, CA/CF key 16 is specified.
//  WDFACKY3                 char(1)   pos(14)  // 13 Keys 17 through 24 without option indicators.
//  WDFACK17                                    // 13  Bit(0)(1) If on, CA/CF key 9 is specified.
//  WDFACK18                                    // 13  Bit(1)(1) If on, CA/CF key 10 is specified.
//  WDFACK19                                    // 13  Bit(2)(1) If on, CA/CF key 11 is specified.
//  WDFACK20                                    // 13  Bit(3)(1) If on, CA/CF key 12 is specified.
//  WDFACK21                                    // 13  Bit(4)(1) If on, CA/CF key 13 is specified.
//  WDFACK22                                    // 13  Bit(5)(1) If on, CA/CF key 14 is specified.
//  WDFACK23                                    // 13  Bit(6)(1) If on, CA/CF key 15 is specified.
//  WDFACK24                                    // 13  Bit(7)(1) If on, CA/CF key 16 is specified.
//  WDFFCMDK                 char(1)   pos(15)  // 14 Other command keys without option indicators.
//  WDFFRLUP                                    // 14  Bit(0)(1) If on, ROLLUP keyword is specified.
//  WDFFRLDN                                    // 14  Bit(1)(1) If on, ROLLDOWN keyword is specified.
//  WDFFPRNT                                    // 14  Bit(2)(1) If on, PRINT keyword is specified.
//  WDFFHOME                                    // 14  Bit(3)(1) If on, HOME keyword is specified.
//  WDFFCLR                                     // 14  Bit(4)(1) If on, CLEAR keyword is specified.
//  WDFFHELP                                    // 14  Bit(5)(1) If on, HELP keyword is specified.
//  Reserved                                    // 14  Bit(6)(2) Reserved
//  WDFFPUTK                 char(2)   pos(16)  // 15 Miscellaneous PUT conditions.
//  WDFFFSEL                                    // 15  Bit(0)(1) If on, field selection.
//  WDFFPUTR                                    // 15  Bit(1)(1) If on, PUTRETAIN keyword is specified on some fields for this format.
//  WDFFVSLN                                    // 15  Bit(2)(1) If on, SLNO(*VAR) keyword is specified.
//  WDFFALRL                                    // 15  Bit(3)(1) If on, ALWROL keyword is specified.
//  WDFFNOCO                                    // 15  Bit(4)(1) Currently set for records containing floating point fields or DBCS data that requires a DBCS device (refer to WDFFRIDV).
//  WDFFALGP                                    // 15  Bit(5)(1) If on, unconditioned ALWGPH keyword is specified.
//  WDFFRDMD                                    // 15  Bit(6)(1) If on, DSPMOD keyword is specified.
//  WDFFRMID                                    // 15  Bit(7)(1) If on, MSGID keyword is specified on field in record.
//  WDFFRKEY                                    // 16  Bit(0)(1) If on, RETKEY keyword is specified.
//  WDFFRCKY                                    // 16  Bit(1)(1) If on, RETCMDKEY keyword is specified.
//  WDFFRDVL                                    // 16  Bit(2)(1) If on, DFTVAL keyword is specified on field.
//  WDFFVSL1                                    // 16  Bit(3)(1) If on, SLNO(*VAR) keyword is specified and a field in row 1, column 1 is specified for at least one display size.
//  WDFFMSGA                                    // 16  Bit(4)(1) If on, unconditioned MSGALARM keyword is specified.
//  WDFFRLST                                    // 16  Bit(5)(1) If on, unconditioned RETLCKSTS keyword is specified.
//  WDFFURDS                                    // 16  Bit(6)(1) If on, unconditioned USRRSTDSP keyword is specified.
//  WDFFRMVW                                    // 16  Bit(7)(1) If on, unconditioned RMVWDW keyword is specified
//  WDFFGETK                 char(2)   pos(18)  // 17 Miscellaneous get conditions.
//  Reserved                                    // 17  Bit(0)(1) Reserved
//  WDFFLOGN                                    // 17  Bit(1)(1) If on, LOGINP keyword is specified.
//  WDFFINZR                                    // 17  Bit(2)(1) If on, INZRCD keyword is specified.
//  WDFFRTND                                    // 17  Bit(3)(1) If on, RTNDTA keyword is specified.
//  WDFFUNLK                                    // 17  Bit(4)(1) If on, UNLOCK keyword is specified.
//  WDFFRSET                                    // 17  Bit(5)(1) If on, UNLOCK(*MDTOFF) keyword specified or UNLOCK keyword specified with GETRETAIN.
//  WDFFEARS                                    // 17  Bit(6)(1) If on, UNLOCK(*ERASE) keyword specified or UNLOCK keyword specified without GETRETAIN.
//  WDFFASUM                                    // 17  Bit(7)(1) If on, ASSUME keyword is specified.
//  WDFFKEEP                                    // 18  Bit(0)(1) If on, KEEP keyword is specified.
//  Reserved                                    // 18  Bit(1)(1) Reserved
//  WDFFWDWR                                    // 18  Bit(2)(1) If on, WINDOW keyword specified in record.
//  WDFFQILE                                    // 18  Bit(3)(1) If on, SFLPGMQ(276) keyword is specified.
//  WDFFSFLCHCCTL                               // 18  Bit(4)(1) If on, SFLCHCCTL keyword is specified.
//  Reserved                                    // 18  Bit(5)(3) Reserved
    QDFFERRM               binDec(4:0) pos(21); // 20 WDFFERRM Index to first field in index table with either ERRMSG or ERRMSGID keyword. 0, if record has no field with either keyword. See structure QDFFFITB
//  WDFFBITS                 char(1)   pos(23); // 22 Miscellaneous flags.
//  WDFFERIN                                    // 22  Bit(0)(1) If on, unconditioned ERASEINP(*MDTON) keyword is specified and ERASEINP(*ALL) is not specified.
//  WDFFMDTO                                    // 22  Bit(1)(1) If on, unconditioned MDTOFF(*UNPR) is specified and MDTOFF(*ALL) is not specified.
//  Reserved                                    // 22  Bit(2)(6)
    WDFFBITF                 char(1)   pos(24); // 23	Miscellaneous flags.
//  Reserved                                    // 23  Bit(0)(2) Reserved
//  WDFFBLKC                                    // 23  Bit(2)(2) Blink flags. X'00' is defined as reserved; X'01' is defined as blink cursor and keyword BLINK unconditioned; X'10' is defined as reset blink cursor and no keyword BLINK; X'11' is defined as reserved.
//  WDFFNOLK                                    // 23  Bit(4)(1) If on, no unconditioned lock. 0 is defined as lock unconditioned (do not unlock keyboard); 1 is defined as no LOCK keyword or conditioned lock (unlock keyboard).
//  WDFFALRM                                    // 23  Bit(5)(1) If on, ALARM keyword unconditioned.
//  Reserved                                    // 17  Bit(6)(1) Reserved
    QDFFCGRI               binDec(4:0) pos(25); // 24 WDFFCGRI Response indicator for record-level CHANGE keyword. For files with INDARA keyword, this is the response indicator minus 1. For those without INDARA keyword, this is the response indicator input buffer displacement. -1 shows keyword is not present.
    WDFFHFLG                 char(2)   pos(27); // 26 Help flags.
//  WDFFHSEQ                                    // 26  Bit(0)(1) If on, HLPSEQ keyword on record.
//  WDFFHLP                                     // 26  Bit(1)(1) If on, help specifications on record.
//  WDFFNHLP                                    // 26  Bit(2)(1) If on, record cannot be used as help text. It contains one of the keywords USRDFN, SFL, or SFLCTL.
//  WDFFHRTN                                    // 26  Bit(3)(1) If on, HLPRTN keyword on record.
//  WDFFHTLE                                    // 26  Bit(4)(1) If on, HLPTITLE keyword on record.
//  WDFFHCLR                                    // 26  Bit(5)(1) If on, HLPCLR keyword on record.
//  WDFFCHNG                                    // 26  Bit(6)(1) If on, no parameter for CHANGE keyword.
//  WDFFRPGM                                    // 26  Bit(7)(1) If on, PRINT keyword on record level with *PGM.
//  WDFFHLPC                                    // 27  Bit(0)(1) If on, HLPCMDKEY keyword on record.
//  WDFFRSTCSR                                  // 27  Bit(1)(1) If on, *RSTCSR parameter is specified on the PULLDOWN keyword on the record.
//  WDFFINLY                                    // 27  Bit(2)(1) If on, CSRINPONLY keyword is specified and is unoptioned.
//  WDFFNOSEP                                   // 27  Bit(3)(1) If on, *NOSEPARATOR parameter is specified on the MNUBAR keyword on this record.
//  Reserved                                    // 27  Bit(4)(4) Reserved
    Offset_drlddes         binDec(4:0) pos(29); // 28 WDFFXRDO Displacement to display-record-level device-dependent extension structure from structure QDFFRINF (see structure QDFFXRDP
//  Reserved                 char(2)   pos(31); // 30 Reserved
    QDFFRDOC               binDec(4:0) pos(33); // 32 WDFFRDOC Displacement to keyword category displacement string from structure QDFFRINF. (See structure QDFFCOSA
  end-ds;
//
//  Display-Record-Level-Device-Dependent section extension structure ( QDFFXRDP )
//
  dcl-c  drlddses_len                const(19);
  dcl-ds drlddses    len(drldds_len) qualified; // Offset Dec QDFFXRDP Display-Record-Level-Device-Dependent section extension structure
//  QDFFFOTO               binDec(8:0) pos(1) ; // 00 WDFFOTO Displacement to field order table from structure QDFFRINF (see structure QDFFOT
    offset_drldds          binDec(8:0) pos(5) ; // 04 WDFFNRCO Displacement to first field name in row-column order table (see variable WDFFDRCO in structure QDFFRDPD. For every row-column table, there is a corresponding field name in row-column order in the field name table (see structure QDFFNTB
//  Reserved                 char(4)   pos(9) ; // 08 Reserved
    QDFFSEGS               binDec(4:0) pos(13); // 12 WDFFNUMOFSEGS Number of segments in record for CNTFLD and EDTMSK.
//  Reserved                 char(2)   pos(15); // 14 Reserved
    QDFHCTLO               binDec(4:0) pos(17); // 16 Buffer displacement to the field containing control for selection list.
//  Reserved                 char(6)   pos(19); // 18 Reserved
  end-ds;
//
//  Row-Column table entry ( QDFFRCTE )
//
  dcl-c  rcte_len                    const(19);
  dcl-ds rcte          len(rcte_len) qualified; // Offset Dec QDFFRCTE Row-Column table entry ( QDFFRCTE )
    row                        char(1) pos(1) ; // 00 WDFFSROW 	Starting row. X'FF' indicates that the location for the secondary display size was *NOLOC, or was a hidden field, a program field, or a message line.
    col                        char(1) pos(2) ; // 01 WDFFSCOL 	Starting column. X'FF' indicates that the location for the secondary display size was *NOLOC, or was a hidden field, a program field, or a message line.
  end-ds;

//==========================================================================================
// Start of moved field definitions.
//==========================================================================================
  dcl-s Format                char(8) inz('DSPF0100');
  dcl-ds QDspFil qualified;               
    fileName   char(10);
    libaryName char(10);
  end-ds;
//==========================================================================================
// End of moved field definitions.
//==========================================================================================
  oi_Row = 0;
  oi_Col = 0;
  QDspFil.fileName = is_FileName ;
  QDspFil.libaryName = is_FileLib;

  callp QDFRTVFD(RcvVar:RcvVarLen:Format:QDspFil:ApiErrDs);

  if ApiErrLen > 0;
    return;
  endif;

  bfs = %subst(RcvVar:1:bfs_length);              // Fill in Data Structure Base file section
  if bfs.offset_sst > 0;
    sst = %subst(RcvVar:bfs.offset_sst:sst_len);  // Fill in Data Structure Sort Sequence Table
  endif;
  
  SDFFINFO = bfs.offset_fhs + 1;
  fhs = %subst(RcvVar:SDFFINFO:fhs_length);       // Fill in Data Structure File header section
  
  SDFARFTE = SDFFINFO + fhs.headerLen;
//  LDFARFTE = bfs.numberOfRecords * bfs_length; //16;            // What is this 16?
  dspfRecAtrbutes    = *Blank;
//
// Fill in screen names.
//
  Idx = 1;
  dow Idx <= bfs.numberOfRecords;
    rft = %subst(RcvVar:SDFARFTE:rft_length);
    dspfRecAtrbutes(Idx) = rft;
    dspfRecNames(Idx)    = rft.recName;
    Idx                  = Idx + 1;
    SDFARFTE             = SDFARFTE + rft_length;
  enddo;

  Idx = 1;

  Idx = %lookup(is_RcdFmt:dspfRecNames);          // If screen name found continue
  
  if Idx > 0 ;
    rft = dspfRecAtrbutes(Idx);                   // Fill in Data Structure
    SDFFRINF = SDFFINFO + rft.offset_rhs;
    rhs = %subst(RcvVar:SDFFRINF:rhs_length);     // Fill in Data Structure
    SDFFRDPD = SDFFRINF + rhs.offset_drldds;
    
    drldds = %subst(RcvVar:SDFFRDPD:drldds_len);  // Fill in Data Structure
    SDFFRCTE = SDFFRINF + drldds.offset_rct + 6;
    SDFFXRDP = SDFFRINF + drldds.Offset_drlddes;
    drlddses = %subst( RcvVar:SDFFXRDP:24 );      // Fill in Data Structure
    SDFFNTB  = SDFFRINF + drlddses.offset_drldds;
    dspfFieldNames    = *Blank;
    FldRC    = *Blank;

    Idx  = 1;                                     // Fill in Field Names?
    dow Idx <= rhs.numOfRec;
      dspfFieldNames(Idx) = %subst(RcvVar:SDFFNTB:10);
      FLDRC(Idx) = %subst(RcvVar:SDFFRCTE:2);
      Idx          = Idx      +  1;
      SDFFNTB      = SDFFNTB  + 10;
      SDFFRCTE     = SDFFRCTE +  2;
    enddo;
    
    Idx = 1;
///End-Free
// >>>>> Not converted: Conversion not currently supported.
//    is_FldNam        LookUp    FldNm( Idx )                           11
///Free
//    if *In11 = True;
//dump;
    Idx = %lookup(is_FldNam:dspfFieldNames);
    if Idx > 0 ;
      RC1   = X'00';
///End-Free
// >>>>> Not converted: Data type Conversion necesssary
//                  MoveA     FldRC( Idx )  QDFFRCTE
      rcte = FldRC( Idx );
///Free
      RC2 = rcte.row;
      oi_Row = RC12;
      RC2 = rcte.col;
      oi_Col = RC12;
      oi_Col = oi_Col + 1;

      if oi_Col > 80;
        oi_Col = oi_Col - 80;
        oi_Row = oi_Row + 1;
      endif;

    endif;
  endif;
  return;
end-proc;
/EndIf
