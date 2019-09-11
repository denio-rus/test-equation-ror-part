require 'rails_helper'

RSpec.describe EquationsController, type: :controller do
  describe 'GET #request_form' do
    before { get :request_form }

    it 'assigns a new instance of Equation to @equation' do
      expect(assigns(:equation)).to be_an_instance_of(Equation)
    end

    it 'renders request_form template' do
      expect(response).to render_template :request_form
    end
  end

  describe 'GET #solve' do
    let(:params) { { equation: {a_param: '1', b_param: '-8', c_param: '12', type: 'quadratic'} } }

    before { get :solve, params: params, format: :js }

    it 'assigns a new instance of Equation to @equation' do
      expect(assigns(:equation)).to be_an_instance_of(Equation)
    end

    it 'renders solve template' do
      expect(response).to render_template :solve
    end
  end

end
