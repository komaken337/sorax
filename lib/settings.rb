# -*- coding: shift_jis -*-

require 'singleton'

module Sora
  class Settings
    include Singleton

    def initialize
      @interface = nil  # �g�p����C���^�[�t�F�[�X�N���X(Class)
      @modes = []  # �o�^����Mode��id�̔z��
      @plugins = {}
      @default_mode = nil
      @global_properties = {}  # Sora�S�̂ŋ��ʂ��Ďg����v���p�e�B
      @properties = {}  # �n�b�V���̃n�b�V��
    end

    ##### Interface�֘A #####
    def register_interface(name, path)
      ::Sora::autoload(name, path)
    end

    def interface
      return @interface
    end

    def interface=(interface)
      @interface = Utils::get_class(interface)
    rescue LoadError => e
      Utils::warn("failed to load interface class file(#{e.path.inspect})")
    rescue NameError
      Utils::warn("interface class(#{interface.inspect}) not found")
    end

    ##### Mode�֘A #####
    def register_mode(id, path)
      ::Sora::autoload(id, path)
      @modes << id
    end

    def initialize_mode(id)
      if id.nil?
        Utils::error("tried to initialize nil mode")
      end
      return Utils::get_class(id).new
    rescue LoadError => e
      Utils::error("failed to load mode class file(#{e.path.inspect})")
    rescue NameError
      Utils::error("mode class(#{id.inspect}) not found")
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
      @modes.each do |id|
        yield id
      end
    end

    ##### Plugin�֘A #####
    def register_plugin(name, path)
      require path
      @plugins[name] = Utils::get_class(name)
    end

    # Plugin�N���X(Class)���C�e���[�g����
    def each_plugin
      @plugins.each do |name, klass|
        yield name, klass
      end
    end

    ##### �v���p�e�B #####
    # p1�Ɏ��ʎq���iInterface���CMode���CPlugin���Ȃǁj���Cp2�Ƀv���p�e�B�����w�肷��
    # p2��nil�̏ꍇ�O���[�o���v���p�e�Bp1���Q�Ƃ���
    def [](p1, p2 = nil)
      if !p2.nil?
        if !@properties.include?(p1)
          warn("warning: ���ʎq#{p1}�̓v���p�e�B�������Ă��܂���")
          return nil
        elsif !@properties[p1].include?(p2)
          warn("warning: ���ʎq#{p1}�̃v���p�e�B#{p2}�͑��݂��܂���")
          return nil
        end
        return @properties[p1][p2]
      else  # �O���[�o���v���p�e�B���Q�Ƃ���
        if !@global_properties.include?(p1)
          warn("warning: �O���[�o���v���p�e�B#{p1}�͑��݂��܂���")
          return nil
        end
        return @global_properties[p1]
      end
    end

    # p3��nil�̏ꍇ�O���[�o���v���p�e�Bp1�ɒlp2���Z�b�g
    # �����Ȃ��΁C���ʎqp1�̃v���p�e�Bp2�ɒlp3���Z�b�g
    def []=(p1, p2, p3 = nil)
      if !p3.nil?
        @properties[p1] = {} if !@properties.include?(p1)
        @properties[p1][p2] = p3
      else  # �O���[�o���v���p�e�B��ݒ肷��
        @global_properties[p1] = p2
      end
    end

    # �v���p�e�B��nil�̏ꍇ�̂ݒl��ݒ肷��
    def default(p1, p2, p3 = nil)
      if !p3.nil?
        if !@properties.include?(p1)
          @properties[p1] = {}
          @properties[p1][p2] = p3
        elsif !@properties[p1].include?(p2) || @properties[p1][p2].nil?
          @properties[p1][p2] = p3
        end
      else  # �O���[�o���v���p�e�B��ݒ肷��
        if !@global_properties.include?(p1) || @global_properties[p1].nil?
          @global_properties[p1] = p2
        end
      end
    end
  end
end

$SET = ::Sora::Settings.instance  # �ȈՕ\�L�p�̃O���[�o���ϐ���p��
