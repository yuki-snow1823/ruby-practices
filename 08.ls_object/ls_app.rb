# frozen_string_literal: true

require_relative './file_converter'

class LsApp
  attr_reader :options, :dir

  def initialize(arg, current_dir)
    @options = arg ? correct_option?(arg) : nil
    # TODO: 歓迎要件
    @dir = current_dir
  end

  def display_all
    # 列幅定数
    file_count_per_line = Dir.foreach('.').count / 3
    linefeed_count = 0
    lines = []
    output_lines = []

    Dir.foreach('.').each do |file|
      linefeed_count += 1
      lines << file
      next unless linefeed_count == file_count_per_line

      output_lines << lines
      lines = []
      linefeed_count = 0
    end

    # TODO: 割り切れない場合にエラーが出る。そもそもこの実装方針で良いのか?
    # ここでは二次元配列を返す。他も同様に。
    # ljustに一番長い文字のlength+2くらいで揃えてもいいかも（先にやる）

    output_lines.transpose.each do |l|
      puts l.join('          ')
    end
  end

  def display_reverse
    Dir.glob('*').reverse_each { |file| puts file }
  end

  def display_except_hides
    Dir.glob('*').map { |file| puts file }
  end

  def display_details
    puts "total #{Dir.glob('*').map { |file| File.stat(file).blocks }.sum}"

    Dir.glob('*') do |file|
      stat = File.stat(file)
      file_type = FileConverter.file_type_to_str(stat.mode)
      permission = FileConverter.mode_to_str(stat.mode)
      nlink = stat.nlink
      user_name = FileConverter.uid_to_user_name(stat.uid)
      group_name = FileConverter.gid_to_group_name(stat.gid)
      size = stat.size
      modified_time = FileConverter.mtime_be_correct_format(stat.mtime)
      # TODO: ファイルサイズの右寄せできていないls
      # 一番大きいブロックの文字数
      puts "#{file_type}#{permission}  #{nlink} #{user_name}  #{group_name}  #{size.to_s.rjust(4)} #{modified_time} #{file} #{stat.blocks}"
    end
  end

  private

  def correct_option?(arg)
    args = arg.split('')
    message = if args[0] != '-'
                'オプションの指定方法が間違っています。'
              elsif args.length > 4
                '多すぎるオプションが指定されました。'
              # TODO: まだバリデーションできていない
              elsif !arg.match(/a|r|l/)
                'オプションに指定できない文字が含まれています。'
              end
    raise ArgumentError, message if message

    args.shift
    args
  end
end
