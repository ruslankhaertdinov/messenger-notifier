require 'rails_helper'

describe WhatsApp::SendMessage do
  include_context 'messageable_provider_data'

  it_behaves_like 'messageable_provider'
end
