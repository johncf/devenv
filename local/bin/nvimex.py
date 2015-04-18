#!/usr/bin/env python2

def showhelp():
    print '''============
Installation
============
1.  Make sure you have Neovim's python-client installed.
2.  Place this script somewhere convenient. Optionally alias ':' to it.
    For instance, add this line to ~/.bashrc:
      [ -z "$NVIM_LISTEN_ADDRESS" ] || alias :='~/nvimex.py'
    Example invocation from bash:
      $ : e file1
      $ : diff file1 file2

=====
Usage
=====
(1)   nvimex.py {cmd} [{arg} [...]]
Execute {cmd} in the associated neovim instance.
Note: Current directory of terminal may be different from that of neovim
instance. So be careful when giving relative paths as arguments.
See usage (4) and notes.

(2)   nvimex.py cd {path}
Change directory to {path}. Note that relative paths will also work.

(3)   nvimex.py @
Change directory of neovim instance to the current directory of terminal.
Equivalent to `nvimex.py cd .`

(4)   nvimex.py @{cmd} [{arg} [...]]
Equivalent to executing (3), followed by (1).

Note: The following commands can handle relative addresses w.r.t terminal.
      These commands won't change neovim's current directory as a side effect.
      badd, cd, diff, dr, drop, e, edit, sp, split, vs, vsp, vsplit

Commands that accept multiple file arguments:
badd, e, edit, sp, split, vs, vsp, vsplit
bad[d]     : Add all arguments to the neovim's buffer list.
diff       : Open a new tab and diffsplit the given 2 files.
e[dit]     : Invokes the drop command.
vs[plit],  : If only one argument is provided, split it with terminal window.
sp[lit]      If more are provided, terminal window is replaced with the split
             windows.

==============
Example usages
==============
Edit file1:
$ ~/nvimex.py e file1

Open file1 in a vertical split:
$ ~/nvimex.py vsp file1

Open two files in vertical split, replacing terminal window:
$ ~/nvimex.py vsp file1 file2

Diff file1 file2 in a new tab:
$ ~/nvimex.py diff file1 file2

Add all python files in current directory to bufferlist:
$ ~/nvimex.py badd *.py

Open manpage of bash in new tab (with 'powerman/vim-plugin-viewdoc' plugin):
$ ~/nvimex.py ViewDocMan bash
'''

def abspath_esc(s):
    from os.path import abspath
    return abspath(s).replace(' ', r'\ ')

def _exit(e):
    if e == "1+":
        exit("Expects at least one argument. See --help.")
    elif e == "1":
        exit("Expects exactly one argument. See --help.")
    elif e == "2":
        exit("Expects exactly two arguments. See --help.")

def main(nvim_listen_addr, cmd, *args):
    from neovim import attach
    from neovim.api.nvim import NvimError

    nvim = attach('socket', path=nvim_listen_addr)
    if cmd[0] == '@':
        nvim.command('cd ' + abspath_esc('.'))
        cmd = cmd[1:]
    try:
        if cmd == [ 'bad', 'badd' ]:
            if len(args) == 0:
                _exit("1+")
            for f in args:
                nvim.command('badd ' + abspath_esc(f))
        elif cmd == 'cd':
            if len(args) != 1:
                _exit("1")
            nvim.command(cmd + abspath_esc(args[0]))
        elif cmd in [ 'dr', 'drop', 'e', 'edit' ]:
            if len(args) == 0:
                _exit("1+")
            nvim.command(' '.join(['drop'] + [abspath_esc(f) for f in args]))
        elif cmd in [ 'sp', 'split', 'vs', 'vsp', 'vsplit' ]:
            if len(args) == 0:
                _exit("1+")
            if len(args) == 1:
                nvim.command(cmd + abspath_esc(args[0]))
            else:
                nvim.command('e ' + abspath_esc(args[0]))
                for f in args[1:]:
                    nvim.command(cmd + abspath_esc(f))
        elif cmd == 'diff':
            if len(args) != 2:
                _exit("2")
            nvim.command('tabnew ' + abspath_esc(args[0]))
            nvim.command('diffsplit ' + abspath_esc(args[1]))
        elif cmd != '':
            nvim.command(' '.join((cmd,) + args))
    except NvimError as e:
        print e

if __name__ == '__main__':
    from sys import argv
    from os import environ

    if len(argv) > 1 and argv[1] == '--help':
        showhelp()
        exit()
    if 'NVIM_LISTEN_ADDRESS' not in environ:
        print '$NVIM_LISTEN_ADDRESS not set!'
        exit()
    if len(argv) < 2:
        print 'Usage: ' + argv[0] + ' {cmd} [{args} [...]]'
        print 'See --help for detailed help.'
        exit()
    main(environ['NVIM_LISTEN_ADDRESS'], *argv[1:])

