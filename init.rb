# -*- coding: shift_jis -*-

# Interface�̓o�^
$SET.register_interface(:Interface, "./lib/interface")
$SET.register_interface(:Console, "./lib/interfaces/console")

# Mode�̓o�^
$SET.register_mode(:Mode, "./lib/mode")

# Plugin�̓o�^
$SET.register_plugin(:Plugin, "./lib/plugin")
$SET.register_plugin(:MessageFormatterPlugin, "./lib/plugins/message_formatter")

#
$SET.interface = :Console
$SET.default_mode = :Mode
