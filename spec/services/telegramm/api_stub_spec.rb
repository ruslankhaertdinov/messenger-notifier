require 'rails_helper'

describe Telegramm::ApiStub do
  let(:service) { described_class.new }

  it_behaves_like 'service_api_stub'
end
