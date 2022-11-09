#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative './ls_app'

LsApp.new(ARGV.getopts('l', 'a', 'r')).run
