**Free
/if not defined(linesLeftOnPage)
/define linesLeftOnPage

  dcl-proc linesLeftOnPage;
    dcl-pi *n int(5);
      ii_lines_perPage int(5) const;
      ii_currentLines  int(5) const;
    end-pi;
  
    dcl-s oi_LinesToAdd int(5) inz(0);
    dcl-s wi_currentLines int(5) inz(0);
    
    wi_currentLines = ii_currentLines;
    if wi_currentLines > ii_lines_perPage;
      wi_currentLines = %rem(wi_currentLines:ii_lines_perPage);
    endif;
    if wi_currentLines <> ii_lines_perPage ;
      if wi_currentLines < ii_lines_perPage ;
        oi_LinesToAdd = ii_lines_perPage - wi_currentLines;
      else;
        oi_LinesToAdd = ii_lines_perPage;
        dow wi_currentLines > ii_lines_perPage;
          wi_currentLines -= ii_lines_perPage;
        enddo;
        if wi_currentLines <> 0;
          oi_LinesToAdd = ii_lines_perPage - wi_currentLines;
        endif;
      endif;
    endif;
    
    return oi_LinesToAdd;
    
  end-proc;
  
/endif
