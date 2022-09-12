#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './ls_app'

ls_app = LsApp.new(ARGV[0], Dir.pwd)

options = ls_app.options

# 残り
# arl
# ar
# rl
# al

# TODO: 3行で出すとは？どのくらいで次の行へ進ませるのか 計算が必要かも
# TODO: バイト数の表示を右に揃える
# TODO: 複数条件の場合の実装を考える（このままだと条件ごとに実装だが、効率良くしたい）

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
