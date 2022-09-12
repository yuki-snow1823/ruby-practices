#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './ls_app'

ls_app = LsApp.new(ARGV[0], Dir.pwd)

options = ls_app.options

# arl
# ar
# rl
# al
# rのみ
# lのみ
# 何もない

case options
when ['a']
  ls_app.display_all
when ['r']
  ls_app.display_reverse
else
  ls_app.display_except_hides
end
