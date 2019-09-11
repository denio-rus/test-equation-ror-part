class Equation 
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :a_param, :b_param, :c_param, :type, :result
  
  validates :a_param, presence: true, numericality: true
  validates :b_param, numericality: true
  validates :c_param, numericality: true, if: :quadratic?
  validates :type, presence: true
  
  validate :validate_a_param_not_zero, :validate_type

  def solve(params)
    parse(params)

    if valid? 
      res = Services::EquationSolver.call(self)
      @result = res['result']
      @errors.add(:result, res['error']) if res['error']
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

  def validate_a_param_not_zero
    return if @a_param != 0

    errors.add(:a_param, "Wrong type of equation. If 'a' is zero, it must be a linear type!") if quadratic?
    errors.add(:a_param, "Root can be any number, if 'a' is zero") if linear?
  end
  
  def validate_type
    errors.add(:type, "Wrong title") unless [:linear, :quadratic].include? type
  end
end
