# frozen_string_literal: true

require 'etc'

class FileConverter
  attr_reader :mode

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

  FILE_TYPE_MAP = {
    '01' => 'p',
    '02' => 'c',
    '04' => 'd',
    '06' => 'b',
    '10' => '-',
    '12' => 'l',
    '14' => 's'
  }.freeze

  def self.convert_mode_to_str(mode)
    octal_number_permission = mode.to_s(8).slice(3..5).split('')
    octal_number_permission.map! { |num| PERMISSION_MAP[num] }
    octal_number_permission.join
  end

  def self.convert_file_type_to_str(mode)
    octal_number_file_type = mode.to_s(8).slice(0..1)
    FILE_TYPE_MAP[octal_number_file_type]
  end

  # 権限の先頭のハイフン
  # ユーザーネーム
  def self.user_name(uid)
    Etc.getpwuid(uid).name
  end
end
