class Equation 
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :a_param, :b_param, :c_param, :type, :result
  
  validates :a_param, presence: true, numericality: { other_than: 0 }
  validates :b_param, numericality: true
  validates :c_param, numericality: true, allow_nil: true
  validates :type, presence: true, inclusion: { in: [:linear, :quadratic] }
  
  def solve(params)
    parse(params)

    if valid? 
      res = Services::EquationSolver.call(self)
      @result = res['result']
      errors.add(:result, res['error']) if res['error']
    end
    
    self
  end

  def persisted?
    false
  end
  
  def quadratic?
    type == :quadratic
  end

  def linear?
    type == :linear
  end

  private

  def parse(params)
    @type = params[:type].to_sym
    
    list_of_params = { a: params[:a_param], b: params[:b_param] }
    list_of_params[:c] =  params[:c_param] if quadratic?
    parsed_params = Services::ParamsParser.call(list_of_params)

    @a_param = parsed_params[:a]
    @b_param = parsed_params[:b]
    @c_param = parsed_params[:c] if quadratic?
  end
end
