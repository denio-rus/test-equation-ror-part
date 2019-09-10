class Equation 
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_reader :a_param, :b_param, :c_param, :type, :result
  
  validates :a_param, :b_param, :c_param, numericality: true
  validates :a_param, :type, presence: true
  validate :validate_a_param_not_zero
  validate :validate_type

  def solve(params)
    parse(params)
    @result = valid? ? Services::EquationSolver.call(self) : nil
    self
  end

  def persisted?
    false
  end

  private

  def parse(params)
    parsed_params = Services::ParamsParser.call(a: params[:a_param], 
                                                b: params[:b_param], 
                                                c: params[:c_param])
    @a_param = parsed_params[:a]
    @b_param = parsed_params[:b]
    @c_param = parsed_params[:c]
    @type = params[:type].to_sym
  end

  def validate_a_param_not_zero
    return if @a_param != 0

    errors.add(:a_param, "Wrong type of equation. If 'a' is zero, it must be a linear type!") if type == :quadratic
    errors.add(:a_param, "Root can be any number, if 'a' is zero") if type == :linear
  end
  
  def validate_type
    errors.add(:type, "Wrong title") unless [:linear, :quadratic].include? type
  end
 
end