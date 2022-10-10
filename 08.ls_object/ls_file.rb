# frozen_string_literal: true

require_relative './file_detail_map'
require 'etc'

class LsFile
  attr_reader :name, :file_stat

  DIRECTORY_NUMBER = '40'

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
    permission.map! { |num| PERMISSION_MAP[num] }
    permission.join
  end

  def size
    @file_stat.size
  end

  def blocks
    @file_stat.blocks
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
    @file_stat.mtime.strftime('%b %e %H:%M')
  end
end
