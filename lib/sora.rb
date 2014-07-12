# -*- coding: shift_jis -*-

module Sora
  class Sora
    def initialize(name = "Sora")
      @interface = nil  # ���s����Interface�̃C���X�^���X(Interface)
      @modes = []  # Mode��id�̔z��
      @plugins = {}  # �N������Plugin�̖��O�ƃC���X�^���X�̃n�b�V��(Symbol => Plugin)
      @current_mode = nil  # ���ݎ��s����Mode�̃C���X�^���X(Mode)
      @name = name  # Sora�̕\����(String)

      # �o�^���ꂽMode���n�b�V���Ɋi�[����
      $SET.each_mode do |id|
        @modes << id
      end

      # �o�^���ꂽPlugin�̃C���X�^���X�𐶐����C�n�b�V���Ɋi�[����
      $SET.each_plugin do |id, plugin|
        @plugins[id] = plugin.new
        @plugins[id].sora = self
      end

      # Mode���f�t�H���g�̂��̂ɕύX
      change_mode($SET.default_mode)
    end

    def interface=(interface)
      @interface = interface
    end

    def plugin(name)
      return @plugins[name]
    end

    def name
      return @name
    end

    def change_mode(mode)
      @current_mode = $SET.initialize_mode(mode)
      @current_mode.interface = @interface
      @current_mode.sora = self
    end

    def on_user_message(message)
      @plugins.each do |name, plugin|
        plugin.on_user_message(message)
      end

      @current_mode.on_user_message(message)
    end

    def on_sora_message(message)
      @interface.on_sora_message(message)

      @plugins.each do |name, plugin|
        plugin.on_sora_message(message)
      end
    end
  end
end
