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

# TODO: 3行で出すとは？どのくらいで次の行へ進ませるのか
# TODO: lが実装できた時点で1度提出しペアプロの相談（重複コマンドなど）

case options
when ['a']
  ls_app.display_all
when ['r']
  ls_app.display_reverse
when ['l']
  ls_app.display_details
else
  ls_app.display_except_hides
end
