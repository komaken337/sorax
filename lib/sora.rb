# -*- coding: shift_jis -*-

module Sora
  class Sora
    def initialize(name = "Sora")
      @interface = nil  # ���s����Interface�̃C���X�^���X(Interface)
      @modes = {}  # Mode�̖��O�ƃN���X�̃n�b�V��(Symbol => Class)
      @plugins = {}  # �N������Plugin�̖��O�ƃC���X�^���X�̃n�b�V��(Symbol => Plugin)
      @current_mode = nil  # ���ݎ��s����Mode�̃C���X�^���X(Mode)
      @name = name  # Sora�̕\����(String)

      # �o�^���ꂽMode���n�b�V���Ɋi�[����
      $SET.each_mode do |name, mode|
        @modes[name] = mode
      end

      # �o�^���ꂽPlugin�̃C���X�^���X�𐶐����C�n�b�V���Ɋi�[����
      $SET.each_plugin do |name, plugin|
        @plugins[name] = plugin.new
        @plugins[name].sora = self
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
      if @modes.include?(mode)
        @current_mode = @modes[mode].new
        @current_mode.interface = @interface
        @current_mode.sora = self
      else
        raise "#{mode} not found."
      end
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
