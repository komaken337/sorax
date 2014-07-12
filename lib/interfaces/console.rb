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

        next if handle_command(string)

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

    def handle_command(string)
      case plugin(:CommandParserPlugin).parse(string)
      when :exit
        exit  # FIXME: 終了処理を行う
      when :chmod
        # FIXME: モード変更処理
      when :not_command
        return false
      end
      return true
    end

    # Soraが発言したいときに呼び出すメソッド
    def on_sora_message(message)
      puts(plugin(:MessageFormatterPlugin).format(message))
    end
  end
end
