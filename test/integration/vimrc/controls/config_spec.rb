# frozen_string_literal: true

control 'vimrc is managed' do
  title 'formula should manage .vimrc'

  describe file('/home/vim_user/.vimrc') do
    it { should be_owned_by 'vim_user' }
    its('mode') { should cmp '0644' }
    its('content') { should match(/syntax on/) }
  end
end
