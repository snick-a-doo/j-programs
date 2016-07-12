NB. import.ijs - Load files by name using a search path.
NB.
NB. The path is an array of boxed directory names stored in
NB. 'j_load_path'.  $ j_load_path = N 1 for easy reading.  You shouldn't
NB. have to use 'j_load_path' directly.
NB.
NB. Initially, the path includes the directories under the system
NB. 'addons' directory.  Use 'add_path' to add more directories.  Load
NB. (or import) this file to reset the path to its initial setting.
NB.
NB. Usage:
NB.    load '/home/me/programs/j/import.ijs'
NB.    add_to_path '~/programs/j'
NB.    import 'fun'
NB. Loading '/home/me/programs/j/fun.ijs'

NB. Initialize the path with the sub-directories of the system addons
NB. directory. 
j_load_path =: ,. 1 1 dir jpath '~addons'

NB. Add a directory to the front of the path.  Unix-style tilde
NB. expansion is done before adding.  A trailing slash is added if
NB. it's not already there.
add_to_path =: monad define
dir =. y
if. '~' = {. dir do.
    dir =. (getenv 'HOME') , }. dir
end.
if. '/' ~: }. dir do.
    dir =. dir , '/'
end.
j_load_path =: dir ; j_load_path
empty ''
)

NB. Load a file given its name sans directory and extension.
import =: monad define
file =. y , '.ijs'
candidates =. ,&file &. > , j_load_path
found =. fexist @ > candidates
if. +./ found do.
    path =. > ({. I. found) { candidates
    echo 'Loading ''' , path , ''''
    load path
else.
    echo 'File ''' , file , ''' not found in'
    echo path ''
end.
)
