# -*- coding: shift_jis -*-
# ���͂ɑ΂���ԓ���\�ߗp�ӂ��C���[�U�̓��͂Ƃ�����Ƃ炵���킹��
# �K���ȕԓ����s��
# ���[�U�ɐϋɓI�ɔ����𑣂��ԓ����s���X��������
# TODO: �}�j���A���̊O���t�@�C����
#       �ԓ����K��������D�����҂̈Ӑ}�ɉ����ĕ��ނ��邭�炢�͂�����

require './lib/modes/algorithms/algorithm'

module Sora
  class ElizaAlgorithm < Algorithm
    def on_user_message(message)
      case classify(message[:string])
      when :declarative  # ������
        string = answer_declarative(message[:string])
      when :question  # �^�╶
        string = answer_question(message[:string])
      when :yes  # �m��̕Ԏ�
        string = answer_yes(message[:string])
      when :no  # �ے�̕Ԏ�
        string = answer_no(message[:string])
      else  # �s���i�ԓ����@���������̎�ʂȂǁj
        string = answer_undefined(message[:string])
      end

      sora_message = {}
      sora_message[:from] = :Sora
      sora_message[:string] = string
      sora_message[:time] = Time.now
      sora.on_sora_message(sora_message)
    end

    # �����̎��(�������C�^�╶�Ȃǁj�����ʂ���
    def classify(string)
      # FIXME: ��G�c������
      if string =~ /[?�H]$/
        return :question
      elsif string == "�͂�"
        return :yes
      elsif string == "������"
        return :no
      else
        return :declarative
      end
    end

    def answer_declarative(string)
      return "����ނ�["
    end

    def answer_yes(string)
      list = ["�����ł����I", "�ł����", "�Ȃ�ق�"]
      return spot(list)
    end

    def answer_no(string)
      return answer_yes(string)
    end

    def answer_question(string)
      return "���Ȃ���" + string
    end

    def answer_undefined(string)
      list = ["�悭������܂���", "�ʂ̌��t�ł��肢���܂�"]
      return spot(list)
    end

    # �z��̗v�f�������ג��o����
    def spot(array)
      return array[rand(array.size)]
    end
  end
end
