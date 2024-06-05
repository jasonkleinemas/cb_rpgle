**free
/if defined(qprint_dclf)
/if not defined(qprint_printLine)
/define qprint_printLine
//#----------------------------------------------------------------------------
dcl-proc qPrintLine ;
  dcl-pi *n;
    is_line char(132) const;
  end-pi;
  dcl-ds line qualified;
    line char(132);
  end-ds;
  if %open(qPrint);
    line.line = is_line;
    write qPrint line;
  endif;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc qPrintLog;
  dcl-pi *n;
    is_line char(100) const;
  end-pi;
  if %open(qPrint);
    qPrintLine(%char(%timeStamp()) + ':' + is_line);
  endif;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc qPrintClose;
  if %open(qPrint);
    close qPrint;
  endif;
end-proc;
//#----------------------------------------------------------------------------
dcl-proc qPrintOpen;
  if not %open(qPrint);
    open qPrint;
  endif;
end-proc;
//#----------------------------------------------------------------------------
/endIf
/endIf