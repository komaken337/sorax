# -*- coding: shift_jis -*-

# Interfaceの登録
$SET.register_interface(:Interface, "./lib/interface")
$SET.register_interface(:Console, "./lib/interfaces/console")

# Modeの登録
$SET.register_mode(:Mode, "./lib/mode")

# Pluginの登録
$SET.register_plugin(:Plugin, "./lib/plugin")
$SET.register_plugin(:MessageFormatterPlugin, "./lib/plugins/message_formatter")

#
$SET.interface = :Console
$SET.default_mode = :Mode
