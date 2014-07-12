# -*- coding: shift_jis -*-

require './lib/interface'
require 'readline'

module Sora
  class ReadlineInterface < ConsoleInterface
    def initialize(sora)
      super(sora)
      # FIXME: ConsoleInterface�̃v���p�e�B���g���Ă��邪�CReadlineInterface�ɂ�����
    end

    # �v�����v�g��\�����ă��[�U�̓��͂����߂�
    def prompt_gets(*args)
      return Readline::readline(args.join.encode($SET[:external_encoding])).encode("Shift_JIS")
    end
  end




















end
