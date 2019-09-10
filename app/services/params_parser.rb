class Services::ParamsParser
  def self.call(params)
    self.new.call(params)
  end

  def call(params)
    params.each.with_object({}) { |(p_name, p_value), hash| hash[p_name] = parse(p_value) }
  end

  private

  def parse(parameter)
    return 0 if parameter.blank?

    return "invalid parameter #{parameter}" unless parameter =~ /^(\+|\-)?\d*(\.)?\d*(\/)?\d*(\.)?\d*$/
    
    s = parameter.split('/') 
    return s.first.to_f if s.size == 1
    s.first.to_f / s.last.to_f
  end
end
