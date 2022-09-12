#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './ls_app'

ls_app = LsApp.new(ARGV[0], Dir.pwd)

options = ls_app.options

# arl
# ar
# rl
# al
# aのみ
# lのみ
# rのみ
# 何もない

# if options == %w([a r l])
#   p 'hoge'
# end

if options == ['a']
  ls_app.display_all
else
  ls_app.display_except_hides
end
