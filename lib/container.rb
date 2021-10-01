class Operation
  include Dry::Transaction
  include Dry::Core::Constants

  def initialize(*args)
    super(*args)
  end

  def call(*args)
    super(*args)
  end
end
