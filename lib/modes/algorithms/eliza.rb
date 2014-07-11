# -*- coding: shift_jis -*-
# 入力に対する返答を予め用意し，ユーザの入力とそれを照らし合わせつつ
# 適当な返答を行う
# ユーザに積極的に発言を促す返答を行う傾向がある
# TODO: マニュアルの外部ファイル化
#       返答が適当すぎる．発言者の意図に応じて分類するくらいはしたい

require './lib/modes/algorithms/algorithm'

module Sora
  class ElizaAlgorithm < Algorithm
    def on_user_message(message)
      case classify(message[:string])
      when :declarative  # 平叙文
        string = answer_declarative(message[:string])
      when :question  # 疑問文
        string = answer_question(message[:string])
      when :yes  # 肯定の返事
        string = answer_yes(message[:string])
      when :no  # 否定の返事
        string = answer_no(message[:string])
      else  # 不明（返答方法が未実装の種別など）
        string = answer_undefined(message[:string])
      end

      sora_message = {}
      sora_message[:from] = :Sora
      sora_message[:string] = string
      sora_message[:time] = Time.now
      sora.on_sora_message(sora_message)
    end

    # 発言の種別(平叙文，疑問文など）を識別する
    def classify(string)
      # FIXME: 大雑把すぎる
      if string =~ /[?？]$/
        return :question
      elsif string == "はい"
        return :yes
      elsif string == "いいえ"
        return :no
      else
        return :declarative
      end
    end

    def answer_declarative(string)
      return "ちょむわー"
    end

    def answer_yes(string)
      list = ["そうですか！", "ですよね", "なるほど"]
      return spot(list)
    end

    def answer_no(string)
      return answer_yes(string)
    end

    def answer_question(string)
      return "あなたの" + string
    end

    def answer_undefined(string)
      list = ["よく分かりません", "別の言葉でお願いします"]
      return spot(list)
    end

    # 配列の要素を一つ無作為抽出する
    def spot(array)
      return array[rand(array.size)]
    end
  end
end
