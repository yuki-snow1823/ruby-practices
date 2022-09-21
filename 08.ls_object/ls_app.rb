# frozen_string_literal: true

require_relative './ls_file'

class LsApp
  NUMBER_OF_COLUMNS = 3
  NUMBER_OF_MARGIN = 20

  def initialize(input_options)
    @input_options = input_options
    @options = options
    @files = generate_files
    @files.reverse! if @options&.include?('r')
  end

  def run
    if @options&.include?('l')
      display_long
    else
      display_short
    end
  end

  private

  def options
    @input_options&.split('')&.sort
  end

  def generate_files
    if @options&.include?('a')
      Dir.foreach('.').map { |file_name| LsFile.new(File.stat(file_name), file_name) }
    else
      Dir.glob('*').map { |file_name| LsFile.new(File.stat(file_name), file_name) }
    end
  end

  def display_long
    @files.each do |file|
      puts "#{file.type}#{file.permission} #{file.nlink.to_s.rjust(max_nlink_count, ' ')} #{file.owner}  #{file.group} #{file.block_size.to_s.rjust(2, ' ')} #{file.modified_time} #{file.name}"
    end
  end

  def display_short
    file_names = []
    all_file = []
    @files.each_with_index do |file, i|
      file_names << file.name.ljust(NUMBER_OF_MARGIN, ' ')
      if ((i + 1) % NUMBER_OF_COLUMNS).zero?
        all_file << file_names
        file_names = []
      end
    end
    all_file << file_names unless file_names.empty?
    all_file.map { |file| puts file.join }
  end

  def max_file_size_count
    @files.map { |file| file.block_size.to_s }.max_by(&:length).length
  end

  def max_nlink_count
    @files.map { |file| file.nlink.to_s }.max_by(&:length).length
  end
end
