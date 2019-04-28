class HandleRequest
  include Interactor::Organizer

  organize ValidateParams, SaveMessages
end
