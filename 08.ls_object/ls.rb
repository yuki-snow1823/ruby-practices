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

# TODO: 複数条件の場合の実装を考える（このままだと条件ごとに実装だが、効率良くしたい）
# TODO: 戻り値を使ってこっちで出力する→「戻り値を使う」
# when式が2次元配列を返す→一旦変数で保持→出力

case options
when ['a']
  ls_app.display_all.each { |l| puts l.join('') }
when ['r']
  ls_app.display_reverse.each { |l| puts l.join('') }
when ['l']
  ls_app.display_details.each { |l| puts l }
else
  ls_app.display_except_hides.each { |l| puts l.join('') }
end
