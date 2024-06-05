**Free
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
  dcl-proc qdbgprtWriteLine;
    dcl-pi *n;
      is_line char(132) value;
    end-pi;

    dcl-ds qdbgprtLine qualified;
      fld01 like(is_line);
    end-ds;

    qdbgprtLine.fld01 = is_line;

    write qdbgprt qdbgprtLine;
    
  end-proc;
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
  dcl-proc qdbgprtOpen;
    open qdbgprt;
  end-proc;
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
  dcl-proc qdbgprtClose;
    close qdbgprt;
  end-proc;