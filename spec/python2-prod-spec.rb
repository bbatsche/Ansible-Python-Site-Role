require_relative "lib/bootstrap"

RSpec.configure do |config|
  config.before :suite do
    AnsibleHelper.playbook("playbooks/python-playbook.yml", ENV["TARGET_HOST"], {
      copy_wsgi:      true,
      env_name:       "prod",
      python_version: "2"
    })
  end
end

context "Nginx" do
  include_examples "nginx"
end

describe "Python site" do
  let(:subject) { command "curl -i python.test" }

  include_examples "curl request", "200"
  include_examples "curl request html"

  it "executed Python code" do
    expect(subject.stdout).to match /Phusion Passenger is serving Python 2 code on python\.test/
  end
end
