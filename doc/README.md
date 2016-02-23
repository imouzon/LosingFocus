# LosingFocus
A plugin for Vim that allows you to automatically perform certain tasks when your focus moves away from Vim.

## Why this project exists right now

The basic functions that control this plugin have been tucked away in my personal vim plugin [vimPersonal](https://github.com/imouzon/vimPersonal).

But I think the idea behind it is ["high concept"](https://en.wikipedia.org/wiki/High-concept) enought that it could survive on its own, 
with a few additional options that I am currently thinking about (for instance, autosaving, managing swap files, refreshing NERDTree, etc.).

## Background for LosingFocus

One of my favorite tools in vim is [AutoCorrect](https://github.com/panozzaj/vim-autocorrect 'panozzaj AutoCorrect').
It works almost seamlessly with files that contain both code and writing, like
Rmarkdown files, and is very good at fixing my more common typos (t-e-h, sep-e-rate and so on).
Additionally, it is very satisfying to watch typos disappear as I write them.

However, there is one small issue that I could not get over - when AutoCorrect loads
Vim hangs for a second or two. Not severe, but still aggravating. 
In fact, just aggravating enough that right on the github page it points out that calling it in the `.vimrc` is not the best idea. 
It's just enough time that you lose focus on what you were about to do.

### How LosingFocus Works
Fortunately, Vim knows if it is in focus or not, i.e., it knows if you are the Vim window is the active window. 
Using Focus takes advantage of this to load packages when focus has shifted away from Vim.



{% highlight vim %}
   "How many times has focus been lost (initially = 0)
   let g:autoCorrect_run = 0

   "automatically call autocorrect if focus is lost
   function! AutoAutoCorrect()
      if g:autoCorrect_run == 0
         call AutoCorrect()
         let g:autoCorrect_run = 1
      endif
   endfunction

   au FocusLost * :call AutoAutoCorrect()
{% endhighlight %}

the first part creates a global variable and sets it to 0. The function
`AutoAutoCorrect()` calls `AutoCorrect()` as long as the value
of that global variable is 0 and then changes the value of that
global variable to 1.
Finally,  the `au FocusLost` command calls `AutoAutoCorrect()`
when focus is lost, meaning that the
first time focus is lost it will call `AutoCorrect()` but there after it
will do nothing.
