#!/usr/bin/env python

import pexpect

child = pexpect.spawnu('ssh-keygen -t rsa')
child.expect('id_rsa): ')
child.sendline('\n')
child.expect('Enter passphrase (empty for no passphrase): ')
child.sendline('overtheriverthroughthewoods\n')
child.expect('Enter same passphrase again: ')
child.sendline('overtheriverthroughthewoods\n')

