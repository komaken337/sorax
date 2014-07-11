# -*- coding: shift_jis -*-

module Sora::Utils
  module_function  # Mix-inではなく，名前空間である

  # 名前空間Sora内でsymbolを識別子とする定数を得る
  # シンボル形式のクラス名からClassクラスのインスタンスが欲しくて作った
  def get_class(symbol)
    return ::Sora::const_get(symbol)
  end
end
