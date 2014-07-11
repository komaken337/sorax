# -*- coding: shift_jis -*-

require './lib/mode'

module Sora
  class ChatMode < Mode
    def initialize
      $SET.default(:ChatMode, :algorithm, [:Algorithm, "./lib/modes/algorithms/algorithm"])
      require $SET[:ChatMode, :algorithm][1]
      @algorithm = Utils::get_class($SET[:ChatMode, :algorithm][0]).new
      @algorithm.mode = self
    end

    def on_user_message(message)
      @algorithm.on_user_message(message)
    end

    def on_event(event)
    end
  end
end
