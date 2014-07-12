# -*- coding: shift_jis -*-

require './lib/utils'
require './lib/settings'
begin
  require './init'
rescue LoadError => e
  if e.path.nil? || e.path != './init'
    raise e
  else
    # init.rbがなければ最低限の設定のみ行う
    $SET.register_interface(:Interface, "./lib/interface")
    $SET.register_mode(:Mode, "./lib/mode")
    $SET.interface = :Interface
    $SET.default_mode = :Mode
  end
end
require './lib/sora'

# エンコーディングの変更
$SET.default(:external_encoding, "UTF-8")
[$stdin, $stdout, $stderr].each do |io|
  io.set_encoding($SET[:external_encoding], "Shift_JIS",
                  {:invalid => :replace, :undef => :replace})
end

module Sora
  sora = Sora.new
  if !$SET.interface.nil?
    interface = $SET.interface.new(sora)
  else
    Utils::error("tried to initialize nil interface")
  end
  sora.interface = interface
  interface.main
end
