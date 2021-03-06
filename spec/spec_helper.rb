# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
require 'rspec'
require './lib/vagrant-winrm.rb'
require './lib/vagrant-winrm/plugin.rb'
require './lib/vagrant-winrm/plugin.rb'
require './lib/vagrant-winrm/commands/winrm.rb'
require './lib/vagrant-winrm/commands/winrm_config.rb'
require './lib/vagrant-winrm/commands/winrm_upload.rb'

def mock_env
  let(:idx) { double('idx') }
  let(:communicator) { double('communicator') }
  let(:winrm_config) {
    double('winrm_config', host: 'winrm_super_host', port: 32424, username: 'usern@me', password: 'p4ssw0rd').tap do |config|
      allow(config).to receive(:[]) { |key| config.send(key) }
    end
  }
  let(:config_vm) { double('config_vm', communicator: :winrm) }
  let(:machine_config) { double('machine_config', winrm: winrm_config, vm: config_vm) }

  let(:provider) {
    double('provider', to_sym: :virtualbox).tap do |provider|
      allow(provider).to receive(:capability?).and_return(true)
      allow(provider).to receive(:capability).with(:winrm_info).and_return(winrm_config)
    end
  }

  let(:machine) {
    double(
      'machine',
      config: machine_config,
      name: 'vagrant',
      provider: provider,
      config: machine_config,
      communicate: communicator,
      ui: double('ui', opts: {}),
      state: nil
    )
  }
  let(:env) { double('env', root_path: '', home_path: '', ui_class: '', machine_names: [machine.name], active_machines: [machine], machine_index: idx, default_provider: provider) }
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
