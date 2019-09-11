require 'rails_helper'

feature 'User can request solution of the equation', %q{
  In order to help with math
  As an guest of site
  I'd like to be able to get solution of the equation'
} do
  describe 'Guest' do
    background do
      visit request_form_equations_path
    end
    
    scenario 'solve a linear equation', js: true do
      allow(Services::EquationSolver).to receive(:call).and_return({ 'result' => 5.0 })

      within('.form-linear') do
        fill_in 'equation[a_param]', with: 2
        fill_in 'equation[b_param]', with: -10
        click_on 'Solve'
      end

      expect(page).to have_content "Root is 5.0"
    end

    scenario 'solve a quadratic equation', js: true do 
      allow(Services::EquationSolver).to receive(:call).and_return({ 'result' => 3.0 })

      find('#type-switch').click
      within('.form-quadratic') do
        fill_in 'equation[a_param]', with: 2
        fill_in 'equation[b_param]', with: -6
        fill_in 'equation[c_param]', with: 9
        click_on 'Solve'
      end

      expect(page).to have_content "Root is 3.0"
    end

    scenario 'does not input a_param in a linear equation', js: true do
      within('.form-linear') do
        fill_in 'equation[b_param]', with: -10
        click_on 'Solve'
      end

      expect(page).to have_content "A param must be other than 0"
      expect(page).to_not have_content "Root is"
    end

    scenario 'input b_param with letters in a linear equation', js: true do
      within('.form-linear') do
        fill_in 'equation[a_param]', with: -10
        fill_in 'equation[b_param]', with: 'fr'

        click_on 'Solve'
      end

      expect(page).to have_content "B param is not a number"
      expect(page).to_not have_content "Root is"
    end

    scenario 'input invalid params for a quadratic equation', js: true do 
      find('#type-switch').click
      within('.form-quadratic') do
        fill_in 'equation[a_param]', with: 0
        fill_in 'equation[b_param]', with: '-6645dfvs'
        fill_in 'equation[c_param]', with: 'hello'
        click_on 'Solve'
      end

      expect(page).to have_content "3 error(s) detected:"
      expect(page).to have_content "A param must be other than 0"
      expect(page).to have_content "B param is not a number"
      expect(page).to have_content "C param is not a number"
      expect(page).to_not have_content "Root is"
    end

    scenario 'does not get a solution because of a problem in the remote EqSolver servise', js: true do 
      find('#type-switch').click
      within('.form-quadratic') do
        fill_in 'equation[a_param]', with: 2
        fill_in 'equation[b_param]', with: 3
        fill_in 'equation[c_param]', with: 4
        click_on 'Solve'
      end
      
      expect(page).to have_content "Result Sorry, but our calculator is broken. Try it later."
      expect(page).to_not have_content "Root is"
    end
  end
end