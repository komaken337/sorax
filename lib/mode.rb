# -*- coding: shift_jis -*-

module Sora
  class Mode
    def initialize
    end

    def on_user_message(message)
      print(self.class, "��", message[:from], "���烁�b�Z�[�W���󂯎��܂���", "\n")
    end

    def on_sora_message(message)
      print(self.class, "��", message[:from], "���烁�b�Z�[�W���󂯎��܂���", "\n")
    end

    def on_event(event)
    end
  end
end
