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

    # Sora�������������Ƃ��ɌĂяo�����\�b�h
    def on_sora_message(message)
      print(message[:from], "> ", message[:string], "\n")
    end

    # ���[�U�ɓ��͂����߁C���ʂ�ԋp���郁�\�b�h
    # Plugin��Mode����C�Θb�I�ȓ��삪�K�v�ȍۂɌĂяo�����
    def dialogue(prompt)
      print(prompt)
      return gets.chomp
    end

    # Sora��Plugin�C���X�^���X���擾���邽�߂̊ȈՕ\�L�p���\�b�h
    def plugin(id)
      return @sora.plugin(id)
    end
  end
end
