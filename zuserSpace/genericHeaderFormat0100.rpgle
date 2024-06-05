**Free
//
// Common data structure format 0100
//
// https://www.ibm.com/docs/en/i/7.4?topic=spaces-common-data-structure-formats
//
  dcl-ds genericHeaderFormat0100;
	ghf0100_userArea                      char(64) inz(''); // An area within the user space that is provided for the caller to use to communicate system programmer-related information between applications that use the user space
 	ghf0100_sizeOfGenericHeader           int (10) inz(0 ); // The size of the generic header, in bytes. This does not include the size of the user area.
    ghf0100_structReleaseAndLevel         char(4 ) inz(''); // The release and level of the generic header format for this list. The value of this field is 0100 for generic header format 0100 and 0300 for generic header format 0300. List APIs put this value into the user space.
    ghf0100_formatName                    char(8 ) inz(''); // The name of the format for the list data section.
	ghf0100_apiUsed                       char(10) inz(''); // For format 0100, this is the name of the program-based API that generates the list. For format 0300, this is a reserved field. See the API entry point name field for the API used.
	ghf0100_dateAndTimeCreated            char(13) inz(''); // The date and time when the list was created. The table shows the possible values.
// If pos 1 century 0 assume 19. 2-7 YYMMDD 8-13 HHMMSS
    ghf0100_informationStatus             char(1 ) inz(''); // Whether the information is complete and accurate. The table shows the possible values.
// C - Complete and accurate.
// I - Incomplete. The information that you receive is not accurate or complete.
// P - Partial but accurate. The information that you receive is accurate, 
//     but the API has more information to return than the user space can hold.
 	ghf0100_sizeOfUserSpaceUsed           int (10) inz(0 ); // The combined size of the user area, generic header, input parameter section, header section, and list data section, in bytes. This determines what is changed in the user space.
 	ghf0100_offsetToInputParameterSection int (10) inz(0 ); // The byte offset from the beginning of the user space to the start of the section
 	ghf0100_sizeOfInputParameterSection   int (10) inz(0 ); // The size of the input parameter section, in bytes.
 	ghf0100_offsetToHeaderSection         int (10) inz(0 ); // The byte offset from the beginning of the user space to the start of the section.
 	ghf0100_sizeOfHeaderSection           int (10) inz(0 ); // The size of the header section, in bytes.
 	ghf0100_offsetToListDataSection       int (10) inz(0 ); // The byte offset from the beginning of the user space to the start of the section.
 	ghf0100_sizeOfListDataSection         int (10) inz(0 ); // The size of the list data section, in bytes. For formats that return variable length records, this is zero.
 	ghf0100_numberOfListEntries           int (10) inz(0 ); // The number of fixed-length entries in the list data section.
 	ghf0100_sizeOfEachEntry               int (10) inz(0 ); // The size of each list data section entry, in bytes. All entries are the same size. For formats that return variable length records, this is zero.
 	ghf0100_ccsidOfDataInTheListEntries   int (10) inz(0 ); // The coded character set ID for data in the list entries. If the value is 0, the data is not associated with a specific CCSID and should be treated as hexadecimal data.
 	ghf0100_countryOrRegionID             char(2 ) inz(''); // The country or region identifier of the data written to the user space.
    ghf0100_languageID                    char(3 ) inz(''); // The language identifier of the data written to the user space.
    ghf0100_subsettedListIndicator        char(1 ) inz(''); // A flag that indicates whether the data selected from the list API can be stored in that format. The table shows the possible values.
// 0 - List is not subsetted; all of the information can be stored in the format.
// 1 - List is subsetted. For example, integrated file system names might be longer than the available area in the format. 
	ghf0100_reserved                      char(42) inz(''); // 
  end-ds;
