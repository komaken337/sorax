# -*- coding: shift_jis -*-

require './lib/settings'
begin
  require './init'
rescue LoadError
  # �ݒ�t�@�C�������݂��Ȃ��ꍇ�̓f�t�H���g�l���g��
end

# TODO: �G���R�[�f�B���O��ύX�\�ɂ���
$stdout.set_encoding(Encoding::UTF_8)
$stderr.set_encoding(Encoding::UTF_8)

module Sora
end
