# frozen_string_literal: true

require_relative './ls_file'

class LsApp
  COLUMNS_COUNT = 3
  MARGIN_COUNT = 20

  def initialize(input_options)
    @input_options = input_options
    @ls_files = generate_ls_files
  end

  def run
    @input_options['l'] ? display_long : display_short
  end

  private

  def generate_ls_files
    file_names = @input_options['a'] ? Dir.foreach('.') : Dir.glob('*')
    file_names = file_names.sort.map { |file_name| LsFile.new(file_name) }
    @input_options['r'] ? file_names.reverse : file_names
  end

  def display_long
    puts "total #{@ls_files.map(&:blocks).sum}"
    nlink_count = count_max_text_length(&:nlink)
    owner_count = count_max_text_length(&:owner)
    group_count = count_max_text_length(&:group)
    ls_file_size_count = count_max_text_length(&:size)

    @ls_files.each do |ls_file|
      output = []
      output << "#{ls_file.type}#{ls_file.permission} "
      output << ls_file.nlink.to_s.rjust(nlink_count)
      output << "#{ls_file.owner.to_s.ljust(owner_count)} "
      output << "#{ls_file.group.to_s.ljust(group_count)} "
      output << ls_file.size.to_s.rjust(ls_file_size_count)
      output << ls_file.modified_time.to_s
      output << ls_file.name.to_s
      puts output.join(' ')
    end
  end

  def display_short
    file_names = []
    all_files = []
    @ls_files.each_with_index do |file, i|
      file_names << file.name.ljust(MARGIN_COUNT)
      next unless ((i + 1) % COLUMNS_COUNT).zero?

      all_files << file_names
      file_names = []
      all_files
    end
    all_files << file_names unless file_names.empty?

    # 行列を入れ替えるため最後の配列に足りない要素数を加えています。
    (all_files.first.count - all_files.last.count).times { all_files.last << [] }
    all_files.transpose.each { |file| puts file.join }
  end

  def count_max_text_length
    @ls_files.map { |ls_file| count_text_length(yield ls_file) }.max
  end

  def count_text_length(attribute)
    attribute.to_s.split('').size
  end
end
