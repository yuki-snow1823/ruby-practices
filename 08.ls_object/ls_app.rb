# frozen_string_literal: true

require_relative './file_converter'

class LsApp
  attr_reader :options, :dir

  NUMBER_OF_COLUMNS = 3
  NUMBER_OF_MARGIN = 10

  def initialize(arg, current_dir)
    @options = arg ? correct_option?(arg) : nil
    # TODO: 歓迎要件
    @dir = current_dir
  end

  def display_all
    file_count_per_column = Dir.foreach('.').count.fdiv(NUMBER_OF_COLUMNS).round
    max_file_name_count = Dir.foreach('.').max_by(&:length).length
    linefeed_count = 0
    lines = []
    output_lines = []

    Dir.foreach('.').each_with_index do |file_name, i|
      lines << file_name.ljust(max_file_name_count + NUMBER_OF_MARGIN, ' ')
      linefeed_count += 1
      # ループの最後に行列の数がずれないようにnilをセットする
      if Dir.foreach('.').count - 1 == i && linefeed_count != file_count_per_column
        # 絶対値にすることでファイルが3つ未満の時にも対応
        (output_lines[0].count - lines.count).abs.times { lines << '' }
        output_lines << lines
      end
      next unless linefeed_count == file_count_per_column

      output_lines << lines
      lines = []
      linefeed_count = 0
    end

    output_lines.transpose
  end

  def display_reverse
    file_count_per_column = Dir.glob('*').count.fdiv(NUMBER_OF_COLUMNS).round
    max_file_name_count = Dir.glob('*').max_by(&:length).length
    linefeed_count = 0
    lines = []
    output_lines = []

    Dir.glob('*').reverse.each_with_index do |file_name, i|
      lines << file_name.ljust(max_file_name_count + NUMBER_OF_MARGIN, ' ')
      linefeed_count += 1
      # ループの最後に行列の数がずれないようにnilをセットする
      if Dir.glob('*').count - 1 == i && linefeed_count != file_count_per_column
        # 絶対値にすることでファイルが3つ未満の時にも対応
        (output_lines[0].count - lines.count).abs.times { lines << '' }
        output_lines << lines
      end
      next unless linefeed_count == file_count_per_column

      output_lines << lines
      lines = []
      linefeed_count = 0
    end

    output_lines.transpose
  end

  def display_except_hides
    file_count_per_column = Dir.glob('*').count.fdiv(NUMBER_OF_COLUMNS).round
    max_file_name_count = Dir.glob('*').max_by(&:length).length
    linefeed_count = 0
    lines = []
    output_lines = []

    Dir.glob('*').each_with_index do |file_name, i|
      lines << file_name.ljust(max_file_name_count + NUMBER_OF_MARGIN, ' ')
      linefeed_count += 1
      # ループの最後に行列の数がずれないようにnilをセットする
      if Dir.glob('*').count - 1 == i && linefeed_count != file_count_per_column
        # 絶対値にすることでファイルが3つ未満の時にも対応
        (output_lines[0].count - lines.count).abs.times { lines << '' }
        output_lines << lines
      end
      next unless linefeed_count == file_count_per_column

      output_lines << lines
      lines = []
      linefeed_count = 0
    end

    output_lines.transpose
  end

  def display_details
    max_file_name_count = Dir.glob('*').map { |file| File.stat(file).size.to_s }.max_by(&:length).length
    puts "total #{Dir.glob('*').map { |file| File.stat(file).blocks }.sum}"

    detail_lines = []
    Dir.glob('*') do |file|
      stat = File.stat(file)
      file_type = FileConverter.file_type_to_str(stat.mode)
      permission = FileConverter.mode_to_str(stat.mode)
      nlink = stat.nlink
      user_name = FileConverter.uid_to_user_name(stat.uid)
      group_name = FileConverter.gid_to_group_name(stat.gid)
      size = stat.size.to_s.rjust(max_file_name_count, ' ')
      modified_time = FileConverter.mtime_be_correct_format(stat.mtime)
      detail_lines << "#{file_type}#{permission}  #{nlink} #{user_name}  #{group_name} #{size} #{modified_time} #{file}"
    end
    detail_lines
  end

  def display_all_details
    max_file_name_count = Dir.foreach('.').map { |file| File.stat(file).size.to_s }.max_by(&:length).length
    max_nlink_count = Dir.foreach('.').map { |file| File.stat(file).nlink.to_s }.max_by(&:length).length
    puts "total #{Dir.foreach('.').map { |file| File.stat(file).blocks }.sum}"

    detail_lines = []
    Dir.foreach('.') do |file|
      stat = File.stat(file)
      file_type = FileConverter.file_type_to_str(stat.mode)
      permission = FileConverter.mode_to_str(stat.mode)
      nlink = stat.nlink.to_s.rjust(max_nlink_count, ' ')
      user_name = FileConverter.uid_to_user_name(stat.uid)
      group_name = FileConverter.gid_to_group_name(stat.gid)
      size = stat.size.to_s.rjust(max_file_name_count, ' ')
      modified_time = FileConverter.mtime_be_correct_format(stat.mtime)
      detail_lines << "#{file_type}#{permission}  #{nlink} #{user_name}  #{group_name} #{size} #{modified_time} #{file}"
    end
    detail_lines
  end

  def display_details_reverse
    max_file_name_count = Dir.glob('*').map { |file| File.stat(file).size.to_s }.max_by(&:length).length
    puts "total #{Dir.glob('*').map { |file| File.stat(file).blocks }.sum}"

    detail_lines = []
    Dir.glob('*') do |file|
      stat = File.stat(file)
      file_type = FileConverter.file_type_to_str(stat.mode)
      permission = FileConverter.mode_to_str(stat.mode)
      nlink = stat.nlink
      user_name = FileConverter.uid_to_user_name(stat.uid)
      group_name = FileConverter.gid_to_group_name(stat.gid)
      size = stat.size.to_s.rjust(max_file_name_count, ' ')
      modified_time = FileConverter.mtime_be_correct_format(stat.mtime)
      detail_lines << "#{file_type}#{permission} #{nlink} #{user_name}  #{group_name} #{size} #{modified_time} #{file}"
    end
    detail_lines.reverse
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
