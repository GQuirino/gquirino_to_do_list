class FilterService
  attr_accessor :scope, :filter_by

  def initialize(scope, filter_by = nil)
    @scope = scope
    @filter_by = filter_by.try(:to_sym)
  end

  def call
    return scope unless filter_valid?

    scope.send(filter_by)
  end

  private

  def filter_valid?
    filter_by.present? &&
      ::ToDo::AVAILABLE_STATUS[filter_by].present? &&
      scope.respond_to?(filter_by)
  end
end
