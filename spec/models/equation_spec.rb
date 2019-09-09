require "rails_helper"

RSpec.describe Equation, type: :model do
  it { should validate_presence_of(:a_param) }
  it { should validate_presence_of(:b_param) }
  it { should validate_presence_of(:c_param) }
  it { should validate_numericality_of(:a_param) }
  it { should validate_numericality_of(:b_param) }
  it { should validate_numericality_of(:c_param) }
end