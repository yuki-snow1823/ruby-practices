# frozen_string_literal: true

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

  def display_except_hides
    Dir.glob('*').map { |file| puts file }
  end
end
