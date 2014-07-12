# -*- coding: shift_jis -*-

module Sora
  module Utils
    module_function  # Mix-in�ł͂Ȃ��C���O��Ԃł���

    SoraRuntimeError = Class.new(RuntimeError)

    # �W���G���[�o�͂�Sora Runtime Error��\�����C��O�𔭐�������
    # Ruby�̃G���[�o�͂����ڂ����f�o�b�O�ɗL�p�ȏ���񋟂��邱��
    # �Ȃ��C�O���G���R�[�f�B���O���������w�肳���O�ɌĂяo�����\��������̂ŁC
    # ���{����n�߂Ƃ����ASCII�������g�����Ƃ͐������Ȃ�
    def error(message)
      Kernel::warn("# SORA RUNTIME ERROR: " + message.to_s)
      Kernel::warn("--- the rest is the error output by Ruby interpreter ---")
      raise SoraRuntimeError
    end

    # ���O���Sora����symbol�����ʎq�Ƃ���萔�𓾂�
    # �V���{���`���̃N���X������Class�N���X�̃C���X�^���X���~�����č����
    def get_class(symbol)
      return ::Sora::const_get(symbol)
    end
  end
end
