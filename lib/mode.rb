# -*- coding: shift_jis -*-

module Sora
  class Mode
    attr_accessor :interface, :sora

    def initialize
      @interface = nil
      @sora = nil
    end

    def on_user_message(message)
      @sora.on_sora_message(message)
    end

    def on_event(event)
    end
  end
end
