# frozen_string_literal: true

require_relative './ls_file'

class LsApp
  NUMBER_OF_COLUMNS = 3
  NUMBER_OF_MARGIN = 20

  def initialize(input_options)
    @input_options = input_options
    @ls_files = generate_ls_files
    @ls_files = @ls_files.reverse if @input_options['r']
  end

  def run
    if @input_options['l']
      display_long
    else
      display_short
    end
  end

  private

  def generate_ls_files
    file_names = 
      if @input_options['a']
        Dir.foreach('.')
      else
        Dir.glob('*')
      end
    file_names = file_names.map { |file_name| LsFile.new(file_name) }
    file_names.sort_by{|f| f.name }
  end

  def display_long
    puts "total #{@ls_files.map(&:blocks).sum}"
    @ls_files.each do |ls_file|
      output = []
      output << "#{ls_file.type}#{ls_file.permission} "
      output << ls_file.nlink.to_s.rjust(max_nlink_count)
      output << ls_file.owner.to_s.rjust(max_owner_count)
      output << ls_file.group.to_s.rjust(max_group_count)
      output << " #{ls_file.size.to_s.rjust(max_ls_file_size_count)}"
      output << ls_file.modified_time.to_s
      output << ls_file.name.to_s
      puts output.join(' ')
    end
  end

  def display_short
    file_names = []
    all_files = []
    @ls_files.each_with_index do |file, i|
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
    group_count = @ls_files.map { |file| file.group.to_s.split('').size }
    group_count.max
  end

  def max_owner_count
    owner_count = @ls_files.map { |file| file.owner.to_s.split('').size }
    owner_count.max
  end

  def max_ls_file_size_count
    file_name_count = @ls_files.map { |file| file.blksize.to_s.split('').size }
    file_name_count.max
  end

  def max_nlink_count
    file_nlink_count = @ls_files.map { |file| file.nlink.to_s.split('').size }
    file_nlink_count.max
  end
end
