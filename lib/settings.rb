# -*- coding: shift_jis -*-

require 'singleton'

module Sora
  class Settings
    include Singleton

    def initialize
      @interface = nil  # 使用するインターフェースクラス(Class)
      @modes = []  # 登録したModeのidの配列
      @plugins = {}
      @default_mode = nil
      @global_properties = {}  # Sora全体で共通して使われるプロパティ
      @properties = {}  # ハッシュのハッシュ
    end

    ##### Interface関連 #####
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

    ##### Mode関連 #####
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

    # Modeは変更され得るが，ここでは初期値を指定する
    # 実際に実行中のModeを管理するのはSoraのインスタンス
    def default_mode=(mode)
      @default_mode = mode
    end

    # Modeクラス(Class)をイテレートする
    def each_mode
      @modes.each do |id|
        yield id
      end
    end

    ##### Plugin関連 #####
    def register_plugin(name, path)
      require path
      @plugins[name] = Utils::get_class(name)
    end

    # Pluginクラス(Class)をイテレートする
    def each_plugin
      @plugins.each do |name, klass|
        yield name, klass
      end
    end

    ##### プロパティ #####
    # p1に識別子名（Interface名，Mode名，Plugin名など）を，p2にプロパティ名を指定する
    # p2がnilの場合グローバルプロパティp1を参照する
    def [](p1, p2 = nil)
      if !p2.nil?
        if !@properties.include?(p1)
          warn("warning: 識別子#{p1}はプロパティを持っていません")
          return nil
        elsif !@properties[p1].include?(p2)
          warn("warning: 識別子#{p1}のプロパティ#{p2}は存在しません")
          return nil
        end
        return @properties[p1][p2]
      else  # グローバルプロパティを参照する
        if !@global_properties.include?(p1)
          warn("warning: グローバルプロパティ#{p1}は存在しません")
          return nil
        end
        return @global_properties[p1]
      end
    end

    # p3がnilの場合グローバルプロパティp1に値p2をセット
    # さもなくば，識別子p1のプロパティp2に値p3をセット
    def []=(p1, p2, p3 = nil)
      if !p3.nil?
        @properties[p1] = {} if !@properties.include?(p1)
        @properties[p1][p2] = p3
      else  # グローバルプロパティを設定する
        @global_properties[p1] = p2
      end
    end

    # プロパティがnilの場合のみ値を設定する
    def default(p1, p2, p3 = nil)
      if !p3.nil?
        if !@properties.include?(p1)
          @properties[p1] = {}
          @properties[p1][p2] = p3
        elsif !@properties[p1].include?(p2) || @properties[p1][p2].nil?
          @properties[p1][p2] = p3
        end
      else  # グローバルプロパティを設定する
        if !@global_properties.include?(p1) || @global_properties[p1].nil?
          @global_properties[p1] = p2
        end
      end
    end
  end
end

$SET = ::Sora::Settings.instance  # 簡易表記用のグローバル変数を用意
