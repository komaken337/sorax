# -*- coding: shift_jis -*-

# Interface�̓o�^
$SET.register_interface(:Interface, "./lib/interface")
$SET.register_interface(:ConsoleInterface, "./lib/interfaces/console")

# Mode�̓o�^
$SET.register_mode(:Mode, "./lib/mode")

# Plugin�̓o�^
$SET.register_plugin(:Plugin, "./lib/plugin")
$SET.register_plugin(:MessageFormatterPlugin, "./lib/plugins/message_formatter")

#
$SET[:external_encoding] = "UTF-8"
$SET.interface = :ConsoleInterface
$SET.default_mode = :Mode
$SET[:MessageFormatterPlugin, :message_format] = "%f�̔���: %s"
$SET[:ConsoleInterface, :default_name] = "Markov"
