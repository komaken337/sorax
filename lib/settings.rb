# -*- coding: shift_jis -*-

require 'singleton'

module Sora
  class Settings
    include Singleton

    def initialize
      @interface = nil  # �g�p����C���^�[�t�F�[�X�N���X�̃N���X��
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
        print(property, "��ǂݍ��݂܂���\n")
      end

      def []=(property, value)
        print(property, "��", value, "���������݂܂���\n")
      end
    end
  end
end
