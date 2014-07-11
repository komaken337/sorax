# -*- coding: shift_jis -*-

require './lib/settings'
begin
  require './init'
rescue LoadError
end
require './lib/sora'

# オプションの既定値を設定
$SET.default(:external_encoding, "UTF-8")

# エンコーディングの変更
Encoding.default_external = $SET[:external_encoding]
Encoding.default_internal = "Shift_JIS"
$stdin.set_encoding($SET[:external_encoding], "Shift_JIS")
$stdout.set_encoding($SET[:external_encoding], "Shift_JIS")
$stderr.set_encoding($SET[:external_encoding], "Shift_JIS")

module Sora
  sora = Sora.new
  interface = $SET.interface.new(sora)
  sora.interface = interface
  interface.main
end
