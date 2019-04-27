shared_context 'messageable_provider' do
  describe '#call' do
    subject { service.call }

    it { is_expected.to eq(true) }
  end
end
