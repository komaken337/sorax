# -*- coding: shift_jis -*-

# Interface�̓o�^
$SET.register_interface(:Interface, "./lib/interface")
$SET.register_interface(:ConsoleInterface, "./lib/interfaces/console")

# Mode�̓o�^
$SET.register_mode(:Mode, "./lib/mode")
$SET.register_mode(:ChatMode, "./lib/modes/chat")

# Plugin�̓o�^
$SET.register_plugin(:Plugin, "./lib/plugin")
$SET.register_plugin(:MessageFormatterPlugin, "./lib/plugins/message_formatter")

#
$SET[:external_encoding] = "UTF-8"
$SET.interface = :ConsoleInterface
$SET.default_mode = :ChatMode
$SET[:ConsoleInterface, :dont_ask_name] = true
$SET[:ChatMode, :algorithm] = [:ElizaAlgorithm, "./lib/modes/algorithms/eliza"]
