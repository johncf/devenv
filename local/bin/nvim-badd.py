#!/bin/python2

import os
def main(nvim_listen_addr, *files):
    from neovim import attach
    nvim = attach('socket', path=nvim_listen_addr)
    for f in files:
        nvim.command('badd ' + os.path.abspath(f))

if __name__ == '__main__':
    import sys
    if 'NVIM_LISTEN_ADDRESS' not in os.environ:
        print '$NVIM_LISTEN_ADDRESS not set!'
        exit()
    if len(sys.argv) < 2:
        print 'Usage: ' + sys.argv[0] + ' {file} ...'
        exit()
    main(os.environ['NVIM_LISTEN_ADDRESS'], *sys.argv[1:])
