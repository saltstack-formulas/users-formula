# frozen_string_literal: true

control 'users configuration' do
  title 'should match desired lines'

  describe file('/custom/buser') do
    its('type') { should eq :directory }
    it { should be_owned_by 'buser' }
    it { should be_grouped_into 'primarygroup' }
    its('mode') { should cmp '0750' }
  end
end
