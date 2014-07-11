# -*- coding: shift_jis -*-

require 'readline'
require './lib/interface'

module Sora
  class ConsoleInterface < Interface
    def initialize(sora)
      super(sora)
      @user_name = nil
      $SET.default(:ConsoleInterface, :default_name, "User")
    end

    def main
      @user_name = ask_user_name

      while true
        string = Readline.readline(@user_name + "> ", true).encode
        if !string  # Ctrl+D
          printf("\n")
          exit
        end

        user_message = {}
        user_message[:from] = "User"
        user_message[:string] = string
        user_message[:time] = Time.now
        @sora.on_user_message(user_message)
      end
    end

    def ask_user_name
      name = Readline.readline("Your name> ").encode
      if name =~ /^\s*$/
        name = $SET[:ConsoleInterface, :default_name]
        puts("デフォルト名#{name}を使用します")
      end
      return name
    end

    # Soraが発言したいときに呼び出すメソッド
    def on_sora_message(message)
      puts(@sora.plugin(:MessageFormatterPlugin).format(message))
    end
  end
end
