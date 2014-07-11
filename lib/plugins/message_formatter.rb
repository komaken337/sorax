# -*- coding: shift_jis -*-

require './lib/plugin'

module Sora
  class MessageFormatterPlugin < Plugin
    def initialize
      super
      # �v���p�e�B�̃f�t�H���g�l��ݒ�
      $SET.default(:MessageFormatterPlugin, :message_format, "%f> %s (%t)")
      $SET.default(:MessageFormatterPlugin, :time_format, "%Y-%m-%d %H:%M:%S")
    end

    # %f: ���M�҂̖��O
    # %s: ���b�Z�[�W�̓��e
    # %t: ���M����
    def format(message, fmt = $SET[:MessageFormatterPlugin, :message_format])
      result = fmt.gsub(/%(.)/) do
        case $1
        when "f"
          message[:from]
        when "s"
          message[:string]
        when "t"
          format_time(message[:time])
        when "%"
          "%"
        else
          ""
        end
      end
      return result
    end

    def format_time(time, fmt = $SET[:MessageFormatterPlugin, :time_format])
      return time.strftime(fmt)
    end
  end
end
