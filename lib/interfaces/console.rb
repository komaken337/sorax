# -*- coding: shift_jis -*-

require './lib/interface'

module Sora
  class ConsoleInterface < Interface
    def initialize(sora)
      super(sora)
      @user_name = nil
      $SET.default(:ConsoleInterface, :default_name, "User")
      $SET.default(:ConsoleInterface, :dont_ask_name, false)
    end

    def main
      @user_name = ask_user_name

      while true
        print(@user_name, "> ")
        string = gets.chomp
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
      return $SET[:ConsoleInterface, :default_name] if $SET[:ConsoleInterface, :dont_ask_name]
      print("Your name?> ")
      name = gets.chomp
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
