# -*- coding: shift_jis -*-

module Sora
  class Sora
    def initialize(name = "Sora")
      @interface = nil  # 実行中のInterfaceのインスタンス(Interface)
      @modes = []  # Modeのidの配列
      @plugins = {}  # 起動中のPluginの名前とインスタンスのハッシュ(Symbol => Plugin)
      @current_mode = nil  # 現在実行中のModeのインスタンス(Mode)
      @name = name  # Soraの表示名(String)

      # 登録されたModeをハッシュに格納する
      $SET.each_mode do |id|
        @modes << id
      end

      # 登録されたPluginのインスタンスを生成し，ハッシュに格納する
      $SET.each_plugin do |id, plugin|
        @plugins[id] = plugin.new
        @plugins[id].sora = self
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
