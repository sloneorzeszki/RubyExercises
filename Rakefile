require 'rspec/core/rake_task'

task :default => :run

desc "Run caesar's cipher"
task :run do 
	ruby "-w ./lib/caesar_cipher.rb"
end

desc "Run tests on caesar's cipher"
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = "-c -w"
	t.verbose = false
end