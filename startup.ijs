NB. Startup script for interactive J sessions.
NB. Place in jpath '~config'

NB. Add path to local programs.
UserFolders_j_ =. UserFolders_j_ , 'my' ; home , '/programs/J'

NB. Box display style
set_box =: 9!:7
unicode_box =: (16 + i.11) { a.
ascii_box =: '+++++++++|-'
minimal_box =: '.........  '
NB. Horizontal line is too long on Android/Debian.  Replace with ASCII
NB. hyphen.
NB. set_box '-' _1 } unicode_box

NB. Shell-like commands.  You can also use the 'shell' verb.
pwd =: 1!:43
cd =: monad define
1!:44 y
pwd ''
)
ls =: dir
rm =: ferase
cat =: freads
