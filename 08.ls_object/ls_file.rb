# frozen_string_literal: true

class LsFile
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

  def initialize(file)
    file_stat = File.stat(file)
    @mode = convert_mode_to_str(file_stat.mode)
    @nlink = file_stat.nlink
  end

  def convert_mode_to_str(mode)
    octal_number_permission = mode.to_s(8).slice(3..5).split('')
    octal_number_permission.map! { |num| p PERMISSION_MAP[num] }
    octal_number_permission.join
  end
end
