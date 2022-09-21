# frozen_string_literal: true

require_relative './file_detail_map'
require 'etc'

class LsFile
  attr_reader :name, :nlink, :block_size

  def initialize(file_stat, name)
    @name = name
    @octal_number_type = file_stat.mode
    @octal_number_permission = file_stat.mode
    @nlink = file_stat.nlink
    @block_size = file_stat.size
    @owner_id = file_stat.uid
    @stat_modified_time = file_stat.mtime
    @group_id = file_stat.gid
  end

  def type
    octal_number_type = @octal_number_type
    TYPE_MAP[octal_number_type.to_s(8).slice(0..1)]
  end

  def permission
    permission = @octal_number_permission
    permission = if permission.to_s(8).slice(0..1) == '40'
                   permission.to_s(8).slice(1..3).split('')
                 else
                   permission.to_s(8).slice(3..5).split('')
                 end
    permission.map! { |num| PERMISSION_MAP[num] }
    permission.join
  end

  def owner
    Etc.getpwuid(@owner_id).name
  end

  def group
    Etc.getgrgid(@group_id).name
  end

  def modified_time
    @stat_modified_time.strftime('%b %e %H:%M')
  end
end
