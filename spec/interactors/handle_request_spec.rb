require 'rails_helper'

describe HandleRequest do
  let(:organizer) do
    [
      ValidateParams,
      SaveMessage
    ]
  end

  it 'организует действия' do
    expect(described_class.organized).to eq(organizer)
  end
end
