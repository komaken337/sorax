# -*- coding: shift_jis -*-

# Interfaceの登録
$SET.register_interface(:Interface, "./lib/interface")
$SET.register_interface(:ConsoleInterface, "./lib/interfaces/console")

# Modeの登録
$SET.register_mode(:Mode, "./lib/mode")

# Pluginの登録
$SET.register_plugin(:Plugin, "./lib/plugin")
$SET.register_plugin(:MessageFormatterPlugin, "./lib/plugins/message_formatter")

#
$SET[:external_encoding] = "UTF-8"
$SET.interface = :ConsoleInterface
$SET.default_mode = :Mode
$SET[:MessageFormatterPlugin, :message_format] = "%fの発言: %s"
$SET[:ConsoleInterface, :default_name] = "Markov"
