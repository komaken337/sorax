# -*- coding: shift_jis -*-

require 'singleton'

module Sora
  class Settings
    include Singleton

    def initialize
      @interface = nil  # 使用するインターフェースクラスのクラス名
    end

    class << self
      def register_interface(class_name, path)
        autoload class_name, path
      end

      def interface
        return @interface
      end

      def interface=(interface)
        warn("warning: already initialized interface") if @interface
        @interface = interface
      end

      def [](property)
        print(property, "を読み込みました\n")
      end

      def []=(property, value)
        print(property, "に", value, "を書き込みました\n")
      end
    end
  end
end
