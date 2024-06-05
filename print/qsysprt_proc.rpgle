**Free
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
  dcl-proc qsysprtWriteLine;
    dcl-pi *n;
      is_line char(132) value;
    end-pi;

    dcl-ds qsysprtLine qualified;
      fld01 like(is_line);
    end-ds;

    qsysprtLine.fld01 = is_line;

    write qsysprt qsysprtLine;
    
  end-proc;
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
  dcl-proc qsysprtOpen;
    open qsysprt;
  end-proc;
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
  dcl-proc qsysprtClose;
    close qsysprt;
  end-proc;