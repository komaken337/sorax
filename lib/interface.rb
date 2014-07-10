# -*- coding: shift_jis -*-

module Sora
  class Interface
    def initialize(sora)
      @sora = sora
      @event_handlers = {}
      @user_name = ""
    end

    def main
      while true
        user_message = gets.chomp
        @sora.on_user_message({\
                                from: "User",\
                                string: user_message,\
                                time: Time.now,\
                              })
      end
    end

    # Soraが発言したいときに呼び出すメソッド
    def on_sora_message(message)
      print(message[:from], "> ", message[:string], "\n")
    end
  end
end
