class Operation
  include Dry::Transaction
  include Dry::Core::Constants

  def initialize(*args)
    super(*args)
  end

  def call(*args)
    super(*args)
  end

  def check_schema_validation(validation)
    if validation.success?
      Success(validation.to_h)
    else
      Failure(type: :input_validation_error, messages: validation.errors(full: true).to_h)
    end
  end
end
