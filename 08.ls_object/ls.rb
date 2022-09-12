#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './ls_app'

ls_app = LsApp.new(ARGV[0], Dir.pwd)

p ls_app.options
