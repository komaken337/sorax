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

    # ユーザに入力を求め，結果を返却するメソッド
    # PluginやModeから，対話的な動作が必要な際に呼び出される
    def dialogue(prompt)
      print(prompt)
      return gets.chomp
    end

    # SoraのPluginインスタンスを取得するための簡易表記用メソッド
    def plugin(id)
      return @sora.plugin(id)
    end
  end
end
