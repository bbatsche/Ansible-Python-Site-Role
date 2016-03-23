require_relative "lib/ansible_helper"
require_relative "bootstrap"

RSpec.configure do |config|
  config.before :suite do
    AnsibleHelper.instance.playbook "playbooks/python-prod-playbook.yml", copy_wsgi: true
  end
end

describe "Nginx config should be valid" do
  include_examples "nginx::config"
end

describe command('curl -i prod-test.dev') do
  its(:stdout) { should match /^HTTP\/1\.1 200 OK$/ }

  its(:stdout) { should match /Phusion Passenger is serving Python 3 code on prod-test\.dev/ }
end
