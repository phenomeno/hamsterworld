#coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
    spec.name           = "NAME"
    spec.version        = '1.0'
    spec.authors        = ["phenomeno"]
    spec.email          = ["writegracelee@gmail.com"]
    spec.summary        = %q{My project.}
    spec.description    = %q{My great project.}
    spec.homepage       = "http://gracehlee.com"
    spec.license        = "MIT"

    sepc.files          = ['lib/NAME.rb']
    spec.executables    = ['bin/NAME']
    spec.test_files     = ['tests/test_NAME.rb']
    spec.require_paths  = ["lib"]
