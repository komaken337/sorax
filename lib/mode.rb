# -*- coding: shift_jis -*-

module Sora
  class Mode
    def initialize
    end

    def on_user_message(message)
      print(self.class, "が", message[:from], "からメッセージを受け取りました", "\n")
    end

    def on_sora_message(message)
      print(self.class, "が", message[:from], "からメッセージを受け取りました", "\n")
    end

    def on_event(event)
    end
  end
end
