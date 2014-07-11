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
  end
end
