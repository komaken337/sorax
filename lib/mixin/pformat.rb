# -*- coding: shift_jis -*-
# pformat: %x�`���̃t�H�[�}�b�g�ɕ������������

module Sora
  module PFormat
    # pcompress: %%��%�ɕϊ����邩�ۂ�
    def pformat(string, pcompress = true, &block)
      array = psplit(string)
      array.map! do |item|
        if item.is_a?(String)
          item
        else
          if item == :%
            (pcompress ? "%" : "%%")
          else
            result = yield(item)
            if result
              result
            else
              "%" + item.to_s
            end
          end
        end
      end
      return array.join
    end

    # "%Y:%M:%D"��[:Y, ":", :M, ":", :D]�ɕϊ�
    # %x��x�Ƃ��ċ������̂̓A���t�@�x�b�g��%�̂�
    def psplit(string)
      result = []
      chunk = ""
      pflg = false
      string.each_char do |c|
        if pflg
          if c =~ /^[A-Za-z%]$/
            result << chunk if !chunk.empty?
            result << c.to_sym
            chunk = ""
          else
            chunk << "%" + c
          end
          pflg = false
        else
          if c == "%"
            pflg = true
          else
            chunk << c
          end
        end
      end
      chunk << "%" if pflg
      result << chunk if !chunk.empty?
      return result
    end

    # %�������G�X�P�[�v����
    def pescape(string)
      string.gsub("%", "%%")
    end
  end
end
