#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './ls_app'

ls_app = LsApp.new(ARGV[0], Dir.pwd)

options = ls_app.options.sort

case options
when %w[a l r]
  puts 'aaa1'
when %w[a r]
  puts 'aaa2'
when %w[a l]
  puts 'aaa3'
when %w[l r]
  puts 'aaa'
when ['a']
  ls_app.display_all.each { |l| puts l.join('') }
when ['r']
  ls_app.display_reverse.each { |l| puts l.join('') }
when ['l']
  ls_app.display_details.each { |l| puts l }
else
  ls_app.display_except_hides.each { |l| puts l.join('') }
end
