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

    # Sora��Plugin�C���X�^���X���擾���邽�߂̊ȈՕ\�L�p���\�b�h
    def plugin(id)
      return @sora.plugin(id)
    end
  end
end
