# -*- coding: shift_jis -*-

module Sora::Utils
  module_function  # Mix-in�ł͂Ȃ��C���O��Ԃł���

  # ���O���Sora����symbol�����ʎq�Ƃ���萔�𓾂�
  # �V���{���`���̃N���X������Class�N���X�̃C���X�^���X���~�����č����
  def get_class(symbol)
    return ::Sora::const_get(symbol)
  end
end
