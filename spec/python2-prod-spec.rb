require_relative "bootstrap"

RSpec.configure do |config|
  config.before :suite do
    AnsibleHelper.playbook("playbooks/python-prod-playbook.yml", ENV["TARGET_HOST"], {
      copy_wsgi: true,
      python_version: "2"
    })
  end
end

context "Nginx" do
  include_examples "nginx"
end

describe command('curl -i prod-test.dev') do
  its(:stdout) { should match /^HTTP\/1\.1 200 OK$/ }

  its(:stdout) { should match /Phusion Passenger is serving Python 2 code on prod-test\.dev/ }
end
