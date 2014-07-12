# -*- coding: shift_jis -*-

require './lib/interface'
require 'readline'

module Sora
  class ReadlineInterface < ConsoleInterface
    def initialize(sora)
      super(sora)
      # FIXME: ConsoleInterfaceのプロパティを使っているが，ReadlineInterfaceにしたい
    end

    # プロンプトを表示してユーザの入力を求める
    def prompt_gets(*args)
      return Readline::readline(args.join.encode($SET[:external_encoding])).encode("Shift_JIS")
    end
  end




















end
