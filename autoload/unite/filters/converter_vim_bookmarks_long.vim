let s:save_cpo = &cpo
set cpo&vim


function! s:format_bookmark(candidate) " {{{
  let file = a:candidate.action__path
  let line_nr = a:candidate.action__line
  let bookmark = a:candidate.action__bookmark
  return printf("%-35s | %s:%d",
        \   bookmark.annotation !=# ''
        \     ? "Annotation: " . bookmark.annotation
        \     : (bookmark.content !=# "" ? bookmark.content[0:34]
        \                                : "empty line"),
        \   file, line_nr
        \ )
endfunction " }}}
let s:converter = {
      \ 'name': 'converter_vim_bookmarks_long',
      \ 'description': 'vim-bookmarks converter which show long informations',
      \}
function! s:converter.filter(candidates, context) " {{{
  for candidate in a:candidates
    let candidate.abbr = s:format_bookmark(candidate)
  endfor
  return a:candidates
endfunction " }}}

function! unite#filters#converter_vim_bookmarks_long#define() " {{{
  return s:converter
endfunction " }}}
call unite#define_filter(s:converter)

let &cpo = s:save_cpo
unlet s:save_cpo
"vim: sts=2 sw=2 smarttab et ai textwidth=0 fdm=marker
