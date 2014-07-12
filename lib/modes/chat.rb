# -*- coding: shift_jis -*-

require './lib/mode'

module Sora
  class ChatMode < Mode
    def initialize
      $SET.default(:ChatMode, :algorithm, [:Algorithm, "./lib/modes/algorithms/algorithm"])
      begin
        require $SET[:ChatMode, :algorithm][1]
        @algorithm = Utils::get_class($SET[:ChatMode, :algorithm][0]).new
        @algorithm.mode = self
      rescue LoadError => e
        Utils::error("failed to load algorithm class file(#{e.path.inspect})")
      rescue NameError
        Utils::error("algorithm class(" + $SET[:ChatMode, :algorithm][0].inspect + ") which is expected to be defined in " + $SET[:ChatMode, :algorithm][1].inspect + " was not found")
      end
    end

    def on_user_message(message)
      @algorithm.on_user_message(message)
    end

    def on_event(event)
    end
  end
end
