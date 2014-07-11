# -*- coding: shift_jis -*-

require './lib/mode'

module Sora
  class ChatMode < Mode
    def initialize
      $SET[:ChatMode, :algorithm] = :Algorithm
    end

    def on_user_message(message)
    end

    def on_sora_message(message)
    end

    def on_event(event)
    end
  end
end
