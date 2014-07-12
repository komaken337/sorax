# -*- coding: shift_jis -*-

require './lib/plugin'

module Sora
  class CommandParserPlugin < Plugin
    def initialize
      super
    end

    def parse(message)
      return :not_command if !(message =~ /^\/([^\s]+)/)  # �u/�R�}���h���v�Ƀ}�b�`
      return $1.to_sym
    end
  end
end
