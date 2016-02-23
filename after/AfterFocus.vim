
call g:LosingFocus("AutoCorrect")

au FocusLost * :call g:RunLosingFocus()
