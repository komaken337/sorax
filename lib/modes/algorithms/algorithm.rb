# -*- coding: shift_jis -*-
# Algorithm�̓��[�U�̃��b�Z�[�W���������CSora�̃��b�Z�[�W��ԋp����
# ChatMode�̈ꕔ�Ƃ��ē��삷��
# ���ׂĂ�Algorithm��base class�Ƃ��āC
# Algorithm�N���X�̓��[�U�̔������I�E���Ԃ��ɂ��铮��(parrot)����������

module Sora
  class Algorithm
    attr_writer :mode

    def initialize
      @mode = nil  # ����Algorithm��@mode�̈ꕔ�Ƃ��ē��삷��i���ʂ�ChatMode�̃C���X�^���X�j
    end

    def interface
      return @mode.interface
    end

    def sora
      return @mode.sora
    end

    def on_user_message(message)
      sora_message = {}
      sora_message[:from] = :Sora
      sora_message[:string] = message[:string]
      sora_message[:time] = Time.now
      sora.on_sora_message(sora_message)
    end

    def on_event(event)
    end
  end
end
