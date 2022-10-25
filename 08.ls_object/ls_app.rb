# frozen_string_literal: true

require_relative './ls_file'

class LsApp
  NUMBER_OF_COLUMNS = 3
  NUMBER_OF_MARGIN = 20

  def initialize(input_options)
    @options = input_options
    @files = generate_ls_files.sort_by{|f| f.name }
    @files = @files.reverse if @options['r']
  end

  def run
    if @options['l']
      display_long
    else
      display_short
    end
  end

  private

  def generate_ls_files
    if @options['a']
      Dir.foreach('.').map { |file_name| LsFile.new(file_name) }
    else
      Dir.glob('*').map { |file_name| LsFile.new(file_name) }
    end
  end

  def display_long
    puts "total #{@files.map { |file| file.blocks }.inject(:+)}"
    @files.each do |file|
      output = []
      output << "#{file.type}#{file.permission}"
      output << file.nlink.to_s.rjust(max_nlink_count, ' ').to_s
      output << file.owner.to_s.rjust(max_owner_count, ' ').to_s
      output << file.group.to_s.rjust(max_group_count, ' ').to_s
      output << file.size.to_s.rjust(max_file_size_count, ' ').to_s
      output << file.modified_time.to_s
      output << file.name.to_s
      puts output.join(' ')
    end
  end

  def display_short
    file_names = []
    all_files = []
    @files.each_with_index do |file, i|
      file_names << file.name.ljust(NUMBER_OF_MARGIN, ' ')
      if ((i + 1) % NUMBER_OF_COLUMNS).zero?
        all_files << file_names
        file_names = []
        all_files
      end
    end
    all_files << file_names unless file_names.empty?

    # 行列を入れ替えるため最後の配列に足りない要素数を加えています。
    if all_files.last.count != all_files.first.count
      (all_files.first.count - all_files.last.count).times { all_files.last << [ ] }
    end
    all_files = all_files.transpose
    all_files.each { |file| puts file.join }
  end

  def max_group_count
    group_count = @files.map { |file| file.group.to_s.split('').size }
    group_count.max
  end

  def max_owner_count
    owner_count = @files.map { |file| file.owner.to_s.split('').size }
    owner_count.max
  end

  def max_file_size_count
    file_name_count = @files.map { |file| file.blksize.to_s.split('').size }
    file_name_count.max
  end

  def max_nlink_count
    file_nlink_count = @files.map { |file| file.nlink.to_s.split('').size }
    file_nlink_count.max
  end
end
