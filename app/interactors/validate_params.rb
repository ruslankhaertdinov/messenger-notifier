class ValidateParams
  include Interactor

  delegate :params, to: :context

  def call
    context.fail!('Invalid params!') if form.invalid?
  end

  private

  def form

  end
end
