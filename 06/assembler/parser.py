A_COMMAND = 'A_COMMAND'
C_COMMAND = 'C_COMMAND'
L_COMMAND = 'L_COMMAND'


class Parser(object):

    def __init__(self, commands):
        self.commands = commands
        self.next_command_index = 0
        self.current_command = None

    def has_more_commands(self):
        return self.next_command_index < len(self.commands)

    def advance(self):
        if self.has_more_commands():
            self.current_command = self.commands[self.next_command_index]
            self.next_command_index += 1

    @property
    def command_type(self):
        if self.current_command.startswith('@'):
            return A_COMMAND
        elif '=' in self.current_command or ';' in self.current_command:
            return C_COMMAND
        elif self.current_command.startswith('('):
            return L_COMMAND
        else:
            raise Exception('Invalid command {}'.format(self.current_command))

    @property
    def symbol(self):
        if self.command_type == A_COMMAND:
            return self.current_command[1:]
        elif self.command_type == L_COMMAND:
            return self.current_command[1:-1]
        else:
            raise Exception('bad command type {}')

    @property
    def dest(self):
        if self.command_type != C_COMMAND:
            raise Exception('bad command type')
        dest_part = self.current_command.split('=')[0]
        dest_mem = ''
        for x in ['A', 'D', 'M']:
            if x in dest_part:
                dest_mem += x
        return dest_mem

    @property
    def comp(self):
        if self.command_type != C_COMMAND:
            raise Exception('bad command type')
        comp_mem = self.current_command.split('=')[-1].split(';')[0]
        return comp_mem

    @property
    def jump(self):
        if self.command_type != C_COMMAND:
            raise Exception('bad command type')
        jump_mem = ''
        parts = self.current_command.split(';')
        if len(parts) > 1:
            jump_mem = self.current_command.split(';')[-1]
        return jump_mem

