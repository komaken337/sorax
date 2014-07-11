# -*- coding: shift_jis -*-
# Algorithmはユーザのメッセージを処理し，Soraのメッセージを返却する
# ChatModeの一部として動作する
# すべてのAlgorithmのbase classとして，
# Algorithmクラスはユーザの発言をオウム返しにする動作(parrot)を実装する

module Sora
  class Algorithm
    attr_writer :mode

    def initialize
      @mode = nil  # このAlgorithmは@modeの一部として動作する（普通はChatModeのインスタンス）
    end

    def interface
      return @mode.interface
    end

    def sora
      return @mode.sora
    end

    def on_user_message(message)
      sora_message = {}
      sora_message[:from] = :Sora
      sora_message[:string] = message[:string]
      sora_message[:time] = Time.now
      sora.on_sora_message(sora_message)
    end

    def on_event(event)
    end
  end
end
