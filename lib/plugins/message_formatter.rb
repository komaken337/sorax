# -*- coding: shift_jis -*-

require './lib/plugin'

module Sora
  class MessageFormatterPlugin < Plugin
    def initialize
      super
    end

    # TODO: フォーマット指定可能にする
    def format(message)
      return message[:from].to_s + "> " +
        message[:string] +
        " (" + format_time(message[:time]) + ")"
    end

    def format_time(time, format = "%m-%d %H:%M:%S")
      return time.strftime(format)
    end
  end
end
