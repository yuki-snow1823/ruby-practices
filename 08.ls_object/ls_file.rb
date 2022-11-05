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
    permission = @file_stat.mode
    permission = if permission.to_s(8).slice(0..1) == DIRECTORY_NUMBER
                   permission.to_s(8).slice(1..3).split('')
                 else
                   permission.to_s(8).slice(3..5).split('')
                 end
    permission.map { |num| PERMISSION_MAP[num] }.join
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

  def owner
    Etc.getpwuid(@file_stat.uid).name
  end

  def group
    Etc.getgrgid(@file_stat.gid).name
  end

  def modified_time
    @file_stat.mtime
  end
end
