# -*- coding: shift_jis -*-

module Sora
  class Plugin
    attr_writer :sora

    def initialize
      @sora = nil
    end

    def on_user_message(message)
    end

    def on_sora_message(message)
    end

    def on_event(event)
    end

    # SoraのPluginインスタンスを取得するための簡易表記用メソッド
    def plugin(id)
      return @sora.plugin(id)
    end
  end
end
