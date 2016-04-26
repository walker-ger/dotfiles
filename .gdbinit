set environment INPUTRC = '$HOME/.gdbinitrc'

alias ds = display
set width 0
set confirm off

define skip
    tbreak +1
    jump +1
end

define dumbwalk
    set $frame = $arg0
    while $frame != 0
        set $fframe = *(void **) $frame
        set $fpc = *(void **) ($frame + 4)
        printf "sp=%x pc=%x\n", $fframe, $fpc
        set $frame = $fframe
    end
end

# note: can't recover from this and it doesn't actually work because derp
define dumbcall
    set $func = $arg0
    set $dummy = $arg1

    set $pc = $func
    set $lr = $dummy
    break $lr
    cont
    print/x $r0
end

define lsof
  shell rm -f pidfile
  set logging file pidfile
  set logging on
  info proc
  set logging off
  shell lsof -p `cat pidfile | perl -n -e 'print $1 if /process (.+)/'`
end

document lsof
  List open files
end

handle SIG32 nostop

# stl printer
add-auto-load-safe-path /home/gdal/gcc/lib64/libstdc++.so.6.0.21-gdb.py

python
import sys
import os
sys.path.insert(0, os.environ['HOME'] + '/.gdb/printers/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style auto
set print sevenbit-strings off


define vgdb
    target remote | vgdb
