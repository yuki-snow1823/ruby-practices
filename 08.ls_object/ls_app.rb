# frozen_string_literal: true

require_relative './file_converter'

class LsApp
  attr_reader :options, :dir

  def initialize(arg, current_dir)
    @options = arg ? correct_option?(arg) : nil
    @dir = current_dir
  end

  def correct_option?(arg)
    args = arg.split('')
    message = if args[0] != '-'
                'オプションの指定方法が間違っています。'
              elsif args.length > 4
                '多すぎるオプションが指定されました。'
              # TODO: まだバリデーションできていない
              elsif !arg.match(/a|r|l/)
                'オプションに指定できない文字が含まれています。'
              end
    raise ArgumentError, message if message

    args.shift
    args
  end

  def display_all
    Dir.foreach('.') { |file| puts file }
  end

  def display_reverse
    Dir.glob('*').reverse_each { |file| puts file }
  end

  def display_except_hides
    Dir.glob('*').map { |file| puts file }
  end

  def display_details
    Dir.glob('*') do |file|
      stat = File.stat(file)
      file_type = FileConverter.file_type_to_str(stat.mode)
      permission = FileConverter.mode_to_str(stat.mode)
      nlink = stat.nlink
      user_name = FileConverter.uid_to_user_name(stat.uid)
      group_name = FileConverter.gid_to_group_name(stat.gid)

      puts "#{file_type}#{permission}  #{nlink} #{user_name} #{group_name}"
    end
  end
end
