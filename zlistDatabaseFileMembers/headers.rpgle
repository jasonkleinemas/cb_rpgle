**Free

  dcl-ds quslmbrInputParameterSection;
    quslmbrips_userSpaceName            char(10) inz('');
    quslmbrips_userSpaceLibraryName     char(10) inz('');
    quslmbrips_formatName               char(8 ) inz('');
    quslmbrips_FileNameSpecified        char(10) inz('');
    quslmbrips_fileLibraryNameSpecified char(10) inz('');
    quslmbrips_memberNameSpecified      char(10) inz('');
    quslmbrips_overrideProcessing       char(1 ) inz('');
  end-ds;

  dcl-ds quslmbrHeaderSection;
    quslmbrlmhs_fileNameUsed        char(10) inz('');
    quslmbrlmhs_librNameUsed        char(10) inz('');
    quslmbrlmhs_fileAttribute       char(10) inz('');
    quslmbrlmhs_fileTextDescription char(50) inz('');
    quslmbrlmhs_numberOfMemebers    int (10) inz(0);
    quslmbrlmhs_sourceFile          char(1 ) inz('');
    quslmbrlmhs_reserved1           char(3 ) inz('');
    quslmbrlmhs_fileCCSID           int (10) inz(0);
  end-ds;
