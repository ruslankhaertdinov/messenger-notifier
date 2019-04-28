require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Messages" do
  header "Accept", "application/json"

  post "/v1/messages" do
    let(:params) do
      {
        message: 'hello',
        whats_app: ['9061111111'],
        viber: ['9062222222'],
        telegram: ['@username']
      }
    end

    context 'валидные параметры' do
      parameter :message, 'Сообщение', type: :string, required: true
      parameter :send_at, 'Желаемое время отправки (отправляется немедленно, если не передано)',
                          type: :string,
                          comment: 'В формате iso8601, например: 2019-04-27T14:08:25+03:00'
      parameter :whats_app, 'Список идендификаторов пользователей для платформы WhatsApp',
                            type: :array,
                            comment: "Пример: { 'whats_app' => ['9061111111'] }",
                            required: true
      parameter :viber, 'Список идендификаторов пользователей для платформы Viber',
                            type: :array,
                            comment: "Пример: { 'viber' => ['90622222222'] }",
                            required: true
      parameter :telegram, 'Список идендификаторов пользователей для платформы Telegram',
                            type: :array,
                            comment: "Пример: { 'telegram' => ['90622222222'] }",
                            required: true

      example_request "успешная обработка запроса (valid params)" do
        expect(response_body['success']).to eq('success')
      end
    end

    context 'невалидные параметры' do
      let(:result) { double(:result, errors: message, success?: false) }
      let(:message) { 'Сообщение было сохранено ранее' }

      before do
        allow(HandleRequest).to receive(:call).and_return(result)
      end

      example_request "возврат сообщения об ошибке (invalid params)" do
        expect(json_response_body['errors']).to contain_exactly(message)
      end
    end
  end
end
