shared_context 'messageable_provider_data' do
  let(:service) { described_class.new(username, message) }
  let(:username) { '@username' }
  let(:message) { 'test message' }
end
