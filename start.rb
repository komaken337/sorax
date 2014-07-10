# -*- coding: shift_jis -*-

require './lib/settings'
begin
  require './init'
rescue LoadError
end
require './lib/sora'

# TODO: エンコーディングを変更可能にする
$stdout.set_encoding(Encoding::UTF_8)
$stderr.set_encoding(Encoding::UTF_8)

module Sora
  sora = Sora.new
  interface = $SET.interface.new(sora)
  sora.interface = interface
  interface.main
end
