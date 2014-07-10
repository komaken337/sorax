# -*- coding: shift_jis -*-

require './lib/interface'

module Sora
  class Console < Interface
    def initialize(sora)
      super(sora)
      @user_name = nil
    end

    def main
      @user_name = ask_user_name

      while true
        print(@user_name, "> ")
        user_message = gets.chomp

        @sora.on_user_message({\
                                from: "User",\
                                string: user_message,\
                                time: Time.now,\
                              })
      end
    end

    def ask_user_name
      print("Your name?> ")
      name = gets.chomp
      name = "User" if name =~ /^\s*$/
      return name
    end

    # Soraが発言したいときに呼び出すメソッド
    def on_sora_message(message)
      puts(@sora.plugin(:MessageFormatterPlugin).format(message))
    end
  end
end
