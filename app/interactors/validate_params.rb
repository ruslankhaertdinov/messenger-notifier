class ValidateParams
  include Interactor

  delegate :params, to: :context

  def call
    return if form.valid?

    context.fail!(errors: form.errors.messages)
  end

  private

  def form
    @form ||= ParamsForm.new(params)
  end
end
