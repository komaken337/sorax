# -*- coding: shift_jis -*-

module Sora
  module Utils
    module_function  # Mix-inではなく，名前空間である

    SoraRuntimeError = Class.new(RuntimeError)

    # 標準エラー出力にSora Runtime Errorを表示し，例外を発生させる
    # Rubyのエラー出力よりも詳しくデバッグに有用な情報を提供すること
    # なお，外部エンコーディングが正しく指定される前に呼び出される可能性があるので，
    # 日本語を始めとする非ASCII文字を使うことは推奨しない
    def error(message)
      Kernel::warn("# SORA RUNTIME ERROR: " + message.to_s)
      Kernel::warn("--- the rest is the error output by Ruby interpreter ---")
      raise SoraRuntimeError
    end

    # 名前空間Sora内でsymbolを識別子とする定数を得る
    # シンボル形式のクラス名からClassクラスのインスタンスが欲しくて作った
    def get_class(symbol)
      return ::Sora::const_get(symbol)
    end
  end
end
