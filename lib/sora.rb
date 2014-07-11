# -*- coding: shift_jis -*-

module Sora
  class Sora
    def initialize(name = "Sora")
      @interface = nil  # 実行中のInterfaceのインスタンス(Interface)
      @modes = {}  # Modeの名前とクラスのハッシュ(Symbol => Class)
      @plugins = {}  # 起動中のPluginの名前とインスタンスのハッシュ(Symbol => Plugin)
      @current_mode = nil  # 現在実行中のModeのインスタンス(Mode)
      @name = name  # Soraの表示名(String)

      # 登録されたModeをハッシュに格納する
      $SET.each_mode do |name, mode|
        @modes[name] = mode
      end

      # 登録されたPluginのインスタンスを生成し，ハッシュに格納する
      $SET.each_plugin do |name, plugin|
        @plugins[name] = plugin.new
        @plugins[name].sora = self
      end

      # Modeをデフォルトのものに変更
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
