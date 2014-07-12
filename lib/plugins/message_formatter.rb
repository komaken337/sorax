# -*- coding: shift_jis -*-

require './lib/plugin'
require './lib/mixin/pformat'

module Sora
  class MessageFormatterPlugin < Plugin
    include PFormat

    def initialize
      super
      # プロパティのデフォルト値を設定
      $SET.default(:MessageFormatterPlugin, :message_format, "%f> %s (%t)")
      $SET.default(:MessageFormatterPlugin, :time_format, "%Y-%m-%d %H:%M:%S")
    end

    # %f: 送信者の名前
    # %s: メッセージの内容
    # %t: 送信時刻
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
