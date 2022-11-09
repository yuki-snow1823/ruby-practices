# frozen_string_literal: true

require 'etc'

class LsFile
  DIRECTORY_NUMBER = '40'

  PERMISSION_MAP = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  TYPE_MAP = {
    '01' => 'p',
    '02' => 'c',
    '40' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }.freeze

  attr_reader :name, :file_stat

  def initialize(file_name)
    @name = file_name
    @file_stat = File.stat(file_name)
  end

  def type
    TYPE_MAP[@file_stat.mode.to_s(8).slice(0..1)]
  end

  def permission
    octal_number_file_mode = @file_stat.mode.to_s(8)
    permission = if directory?(octal_number_file_mode)
                   octal_number_file_mode.slice(1..3)
                 else
                   octal_number_file_mode.slice(3..5)
                 end
    permission.chars.map { |num| PERMISSION_MAP[num] }.join
  end

  def size
    @file_stat.size
  end

  def blocks
    @file_stat.blocks
  end

  def blksize
    @file_stat.blksize
  end

  def nlink
    @file_stat.nlink
  end

  def owner_name
    Etc.getpwuid(@file_stat.uid).name
  end

  def group_name
    Etc.getgrgid(@file_stat.gid).name
  end

  def modified_time
    @file_stat.mtime
  end

  private

  def directory?(octal_number_file_mode)
    octal_number_file_mode.slice(0..1) == DIRECTORY_NUMBER
  end
end
