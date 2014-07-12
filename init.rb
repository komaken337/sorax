# -*- coding: shift_jis -*-

# Interfaceの登録
$SET.register_interface(:ConsoleInterface, "./lib/interfaces/console")

# Modeの登録
$SET.register_mode(:ChatMode, "./lib/modes/chat")

# Pluginの登録
$SET.register_plugin(:MessageFormatterPlugin, "./lib/plugins/message_formatter")
$SET.register_plugin(:CommandParserPlugin, "./lib/plugins/command_parser")
$SET.register_plugin(:LogKeeperPlugin, "./lib/plugins/log_keeper")
$SET.register_plugin(:MeCabParserPlugin, "./lib/plugins/mecab_parser")

$SET[:external_encoding] = "UTF-8"
$SET.interface = :ConsoleInterface
$SET.default_mode = :ChatMode
$SET[:ConsoleInterface, :dont_ask_name] = true
$SET[:ChatMode, :algorithm] = [:ElizaAlgorithm, "./lib/modes/algorithms/eliza"]
