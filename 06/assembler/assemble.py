#!/usr/bin/env python
import sys

from parser import Parser
import code


in_file = sys.argv[1]

with open(in_file, 'r') as f:
    contents = f.read()

commands = []
for line in contents.split('\n'):
    if not line or line.startswith('//'):
        continue
    commands.append(line)

p = Parser(commands)
while p.has_more_commands():
    p.advance()
    command_type = p.command_type
    if command_type == 'A_COMMAND':
        print code.integer(p.symbol)
    elif command_type == 'C_COMMAND':
        print '111' + code.comp(p.comp) + code.dest(p.dest) + code.jump(p.jump)
    elif command_type == 'L_COMMAND':
        pass
