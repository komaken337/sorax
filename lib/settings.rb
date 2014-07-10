# -*- coding: shift_jis -*-

require 'singleton'

module Sora
  class Settings
    include Singleton

    def initialize
      @interface = nil  # 使用するインターフェースクラス(Class)
      @modes = {}
      @plugins = {}
      @default_mode = nil
    end

    ##### Interface関連 #####
    def register_interface(name, path)
      ::Sora::autoload(name, path)
    end

    def interface
      return @interface
    end

    def interface=(interface)
      @interface = Settings.get_class(interface)
    end

    ##### Mode関連 #####
    def register_mode(name, path)
      ::Sora::autoload(name, path)
      @modes[name] = Settings.get_class(name)
    end

    def default_mode
      return @default_mode
    end

    # Modeは変更され得るが，ここでは初期値を指定する
    # 実際に実行中のModeを管理するのはSoraのインスタンス
    def default_mode=(mode)
      @default_mode = mode
    end

    # Modeクラス(Class)をイテレートする
    def each_mode
      @modes.each do |name, klass|
        yield name, klass
      end
    end

    ##### Plugin関連 #####
    def register_plugin(name, path)
      require path
      @plugins[name] = Settings.get_class(name)
    end

    # Pluginクラス(Class)をイテレートする
    def each_plugin
      @plugins.each do |name, klass|
        yield name, klass
      end
    end

    ##### プロパティ #####
    def [](property)
      print(property, "を読み込みました\n")
    end

    def []=(property, value)
      print(property, "に", value, "を書き込みました\n")
    end
  end

  class << Settings
    def get_class(name)
      return ::Sora::const_get(name)
    end
  end
end

$SET = ::Sora::Settings.instance  # 簡易表記用のグローバル変数を用意
