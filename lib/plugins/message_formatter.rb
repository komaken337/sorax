# -*- coding: shift_jis -*-

require './lib/plugin'

module Sora
  class MessageFormatterPlugin < Plugin
    def initialize
      super
      # プロパティのデフォルト値を設定
      $SET.default(:MessageFormatterPlugin, :message_format, "%f> %s (%t)")
      $SET.default(:MessageFormatterPlugin, :time_format, "%Y-%m-%d %H:%M:%S")
    end

    # %f: 送信者の名前
    # %s: メッセージの内容
    # %t: 送信時刻
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
