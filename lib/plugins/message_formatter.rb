# -*- coding: shift_jis -*-

require './lib/plugin'
require './lib/mixin/pformat'

module Sora
  class MessageFormatterPlugin < Plugin
    include PFormat

    def initialize
      super
      # �v���p�e�B�̃f�t�H���g�l��ݒ�
      $SET.default(:MessageFormatterPlugin, :message_format, "%f> %s (%t)")
      $SET.default(:MessageFormatterPlugin, :time_format, "%Y-%m-%d %H:%M:%S")
    end

    # %f: ���M�҂̖��O
    # %s: ���b�Z�[�W�̓��e
    # %t: ���M����
    def format(message, fmt = $SET[:MessageFormatterPlugin, :message_format], time_fmt = nil)
      result = pformat(fmt) do |p|
        case p
        when :f
          message[:from]
        when :s
          message[:string]
        when :t
          if time_fmt
            format_time(message[:time], time_fmt)
          else
            format_time(message[:time])
          end
        end
      end
      return result
    end

    def format_time(time, fmt = $SET[:MessageFormatterPlugin, :time_format])
      return time.strftime(fmt)
    end
  end
end
