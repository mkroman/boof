#!/usr/bin/gem build
# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name     = "boof"
  spec.version  = "0.1"
  spec.summary  = "Microsoft WinCE binary format (B0000FF)"

  spec.license  = "MIT License"
  spec.author   = "Mikkel Kroman"
  spec.email    = "mk@uplink.io"
  spec.files    = Dir["library/**/*.rb"]

  spec.add_dependency "bindata"
  spec.add_development_dependency "rspec"

  spec.require_path = "library"
  spec.required_ruby_version = ">= 1.9.1"
end

# vim: set syntax=ruby:
