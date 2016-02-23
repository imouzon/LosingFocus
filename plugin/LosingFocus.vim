"load large packages the first time the focus is lost


" specifiy which packages should be watched in the vimrc
" using call LosingFocus("AutoCorrect")
function! g:LosingFocus(pkg, ...)

   "check to see if the packages/options list has started already
   if !exists("g:LosingFocusPackages")

      "if we there are no packages/options yet, start the structure
      "check if there are options (the ... arguments)
      if a:0 == 0

         "if there are no arguments
         let g:LosingFocusPackages = [[a:pkg]]

      else

         "if there are arguments
         let g:LosingFocusPackages = [[a:pkg,[a:000]]]

      endif

   else

      "if we there are already packages/options, add the new one
      if a:0 == 0

         "if there are no arguments
         let g:LosingFocusPackages = add(g:LosingFocusPackages, [a:pkg])

      else

         "if there are arguments
         let g:LosingFocusPackages = add(g:LosingFocusPackages, [a:pkg, a:000])

      endif
      
   endif

endfunction


" LosingFocusLoader determines how to handle each packages/options
function! g:LosingFocusLoader(package_call)

   "the argument is a list with the package name as the first
   "and any arguments after as the second element,
   "ex. ['AutoCorrect',['text', 'tex']]

   "if a:package_call has only one entry, we load the pkg w/ no args
   if len(a:package_call) == 1 

      "Special case for autocorrect which has no arguments
      if tolower(a:package_call[0]) == "autocorrect"

         echom "Loading the AutoCorrect package"

         execute "call AutoCorrect()"

      else

         echo "Loading the package" a:package_call[0] "(no arguments)"

         execute "call ".a:package_call[0]."()"

      endif

   else

      let args = join(a:package_call[1], ',')

      echom "Loading the package ".a:package_call[0]."(".args.")"

      "execute "call ".a:package_call[0]."(".args.")"

   endif

endfunction


" Control how to handle packages/options specified by LosingFocus
function! g:RunLosingFocus()

   " determine if we have run the function before or not
   if exists("g:LosingFocus_run_count")

      " run this code if we're losing focus again

      let g:LosingFocus_run_count += 1

      echom "LosingFocus has run again"

   else

      " run this code if we're losing focus for the first time
 
      " packages to load must be stored by LosingFocus
      if exists("g:LosingFocusPackages")

         echom "Focus has been lost. The following tools have been loaded"

         for lfp_i in copy(g:LosingFocusPackages)

            call g:LosingFocusLoader(lfp_i)

         endfor

      endif

      " specify that we have run the variable for the first time
      let g:LosingFocus_run_count = 1

   endif

endfunction
