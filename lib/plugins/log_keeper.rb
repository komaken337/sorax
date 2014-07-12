# -*- coding: shift_jis -*-
# TODO: 日付ごとにディレクトリを作成できるようにする
#       %iのフォーマット指定（%03i→001など）を可能にする
#       ハッシュ値をIDとして使えるようにする（%h？)

require './lib/plugin'
require './lib/mixin/pformat'

module Sora
  class LogKeeperPlugin < Plugin
    include PFormat  # 万能PFormatくん

    def initialize
      super
      $SET.default(:LogKeeperPlugin, :log_dir, "./log/")
      $SET.default(:LogKeeperPlugin, :filename_format, "%t_%i")
      $SET.default(:LogKeeperPlugin, :time_format, "%y%m%d")
      $SET.default(:LogKeeperPlugin, :filename_ext, ".txt")
      $SET.default(:LogKeeperPlugin, :mkdir, false)  # log_dirが存在しないときに作成するか
      $SET.default(:LogKeeperPlugin, :recursive_mkdir, false)  # mkdirがtrueのとき，再帰的にmkdirするか
      $SET.default(:LogKeeperPlugin, :message_format, false)
      @file_path = generate_file_path
      @file_io = File.open(@file_path, "a")  # TODO: 「w」か「a」を選択できるように
    end

    def finalize
      @file_io.close if !@file_io.closed?
    end

    def on_user_message(message)
      on_message(message)
    end

    def on_sora_message(message)
      on_message(message)
    end

    def on_message(message)
      if (message_format = $SET[:LogKeeperPlugin, :message_format])
        @file_io.puts(plugin(:MessageFormatterPlugin).format(message, message_format))
      else
        @file_io.puts(plugin(:MessageFormatterPlugin).format(message))
      end
    end

    def generate_file_path
      format = pescape($SET[:LogKeeperPlugin, :log_dir]) +
        $SET[:LogKeeperPlugin, :filename_format] +
        pescape($SET[:LogKeeperPlugin, :filename_ext])
      time_string = Time.now.strftime($SET[:LogKeeperPlugin, :time_format])
      filename = pformat(format, false) do |p|
        case p
        when :t
          time_string
        end
      end
      filename = format_id(filename)
      return filename
    end

    # %iを重複しないようにIDに置き換える
    def format_id(base_string)
      id = 1
      while true
        filename = pformat(base_string) {|p| id if p == :i}
        break if !FileTest.exists?(filename)
        id += 1
      end
      return filename
    end
  end
end
