#!/bin/python2

def showhelp():
    print '''============
Installation
============
1.  Make sure you have Neovim's python-client installed.
2.  Place this file somewhere convenient. Optionally alias ':' to it.
    Example .bashrc:
      [ -z "$NVIM_LISTEN_ADDRESS" ] || alias :='~/nvimex.py'
3.  Put this function in your nvimrc:
      function LeaveTMode()
        call feedkeys("\<C-\>\<C-N>", 't')
      endfun

=====
Usage
=====
(1)   nvimex.py {cmd} [{arg} [...]]
Execute {cmd} in the associated neovim instance.
Note 1: Current directory of terminal may be different from that of neovim
instance. So be careful when giving relative paths as arguments (see usage (4)).
Note 2: Neovim leaves terminal mode, and enters normal mode.

(2)   nvimex.py cd {path}
Change directory to {path}. Note that relative paths will work regardless of
neovim's current directory. Neovim remains in terminal mode.

(3)   nvimex.py @
Change directory of neovim instance to the current directory of terminal.
Equivalent to `nvimex.py cd .`

(4)   nvimex.py @{cmd} [{arg} [...]]
Equivalent to executing (3), followed by (1).

Command 'badd' accepts multiple file arguments:
(5)   nvimex.py badd {file} [...]
Add all {file} arguments to the neovim's buffer list. Like (2), relative paths
work as well, and it continues to be in terminal mode.

==============
Example usages
==============
Edit file1:
$ ~/nvimex.py @e file1

Open file1 in a vertical split:
$ ~/nvimex.py @vsp file1

Add all python files in current directory to bufferlist:
$ ~/nvimex.py badd *.py

Open manpage of bash in new tab (with 'powerman/vim-plugin-viewdoc' plugin):
$ ~/nvimex.py ViewDocMan bash
'''

import os
def main(nvim_listen_addr, cmd, *args):
    from neovim import attach
    nvim = attach('socket', path=nvim_listen_addr)
    if cmd[0] == '@':
        nvim.command('cd ' + os.path.abspath('.'))
        cmd = cmd[1:]
    if cmd == 'badd':
        if len(args) == 0:
            exit("Expects at least one argument. See --help.")
        for f in args:
            nvim.command('badd ' + os.path.abspath(f))
    elif cmd == 'cd':
        if len(args) != 1:
            exit("Expects exactly one argument. See --help.")
        nvim.command('cd ' + os.path.abspath(args[0]))
    elif cmd != '':
        nvim.command('call LeaveTMode()')
        nvim.command(' '.join([cmd] + args))
    else:
        showhelp()

if __name__ == '__main__':
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == '--help':
        showhelp()
        exit()
    if 'NVIM_LISTEN_ADDRESS' not in os.environ:
        print '$NVIM_LISTEN_ADDRESS not set!'
        exit()
    if len(sys.argv) < 2:
        print 'Usage: ' + sys.argv[0] + ' {cmd} [{args} [...]]'
        print 'See --help for detailed help.'
        exit()
    main(os.environ['NVIM_LISTEN_ADDRESS'], *sys.argv[1:])

