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
  # 3で割って、縦で出力、割った値に達したら改行
  # 改行できなかったらtranspose使う
# TODO: バイト数の表示を右に揃える
# TODO: 複数条件の場合の実装を考える（このままだと条件ごとに実装だが、効率良くしたい）

# TODO: 戻り値を使ってこっちで出力する→「戻り値を使う」
# when式が2次元配列を返す→一旦変数で保持→出力

case options
when ['a']
  ls_app.display_all.each {|l| puts l.join('') }
when ['r']
  ls_app.display_reverse
when ['l']
  ls_app.display_details
else
  ls_app.display_except_hides
end
