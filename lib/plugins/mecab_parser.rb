# -*- coding: shift_jis -*-

require './lib/plugin'

module Sora
  class MeCabParserPlugin < Plugin
    def initialize
      $SET.default(:MeCabParserPlugin, :mecab_path, "/usr/local/bin/mecab")
      $SET.default(:MeCabParserPlugin, :dict_encoding, "UTF-8")
    end

    def on_user_message(message)
      return on_message(message)
    end

    def on_sora_message(message)
      return on_message(message)
    end

    def on_message(message)
      IO.popen($SET[:MeCabParserPlugin, :mecab_path] +
               ' -x "未知語"'.encode($SET[:external_encoding]),
               "w+") do |io|
        io.puts(message[:string].encode($SET[:MeCabParserPlugin, :dict_encoding]))
        io.close_write
        io.each_line do |line|
          line.chomp!
          break if line == "EOS"
          puts(line)
        end
      end
    end
  end
end
