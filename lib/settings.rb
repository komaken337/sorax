# -*- coding: shift_jis -*-

require 'singleton'

module Sora
  class Settings
    include Singleton

    def initialize
      @interface = nil  # �g�p����C���^�[�t�F�[�X�N���X(Class)
      @modes = {}
      @plugins = {}
      @default_mode = nil
    end

    ##### Interface�֘A #####
    def register_interface(name, path)
      ::Sora::autoload(name, path)
    end

    def interface
      return @interface
    end

    def interface=(interface)
      @interface = Settings.get_class(interface)
    end

    ##### Mode�֘A #####
    def register_mode(name, path)
      ::Sora::autoload(name, path)
      @modes[name] = Settings.get_class(name)
    end

    def default_mode
      return @default_mode
    end

    # Mode�͕ύX���꓾�邪�C�����ł͏����l���w�肷��
    # ���ۂɎ��s����Mode���Ǘ�����̂�Sora�̃C���X�^���X
    def default_mode=(mode)
      @default_mode = mode
    end

    # Mode�N���X(Class)���C�e���[�g����
    def each_mode
      @modes.each do |name, klass|
        yield name, klass
      end
    end

    ##### Plugin�֘A #####
    def register_plugin(name, path)
      require path
      @plugins[name] = Settings.get_class(name)
    end

    # Plugin�N���X(Class)���C�e���[�g����
    def each_plugin
      @plugins.each do |name, klass|
        yield name, klass
      end
    end

    ##### �v���p�e�B #####
    def [](property)
      print(property, "��ǂݍ��݂܂���\n")
    end

    def []=(property, value)
      print(property, "��", value, "���������݂܂���\n")
    end
  end

  class << Settings
    def get_class(name)
      return ::Sora::const_get(name)
    end
  end
end

$SET = ::Sora::Settings.instance  # �ȈՕ\�L�p�̃O���[�o���ϐ���p��
