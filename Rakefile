require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :test_init do 
    sh "mkdir -p $HOME/.keg/glean-daimon-lunch"
    sh "git clone git@github.com:bm-sms/glean-daimon-lunch.git $HOME/.keg/glean-daimon-lunch "
end

task :default => :test
