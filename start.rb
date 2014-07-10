# -*- coding: shift_jis -*-

require './lib/settings'
begin
  require './init'
rescue LoadError
  # 設定ファイルが存在しない場合はデフォルト値を使う
end

# TODO: エンコーディングを変更可能にする
$stdout.set_encoding(Encoding::UTF_8)
$stderr.set_encoding(Encoding::UTF_8)

module Sora
end
