# -*- coding: shift_jis -*-
# pformat: %x形式のフォーマットに文字列を代入する

module Sora
  module PFormat
    # pcompress: %%を%に変換するか否か
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

    # "%Y:%M:%D"を[:Y, ":", :M, ":", :D]に変換
    # %xのxとして許されるのはアルファベットと%のみ
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

    # %文字をエスケープする
    def pescape(string)
      string.gsub("%", "%%")
    end
  end
end
