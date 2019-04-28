class HandleRequest
  include Interactor::Organizer

  organize ValidateParams, SaveMessage
end
