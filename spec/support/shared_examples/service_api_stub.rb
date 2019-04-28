shared_context 'service_api_stub' do
  describe '#call' do
    it 'вернёт результат выполнения' do
      expect([true, false]).to include(service.call)
    end
  end
end
