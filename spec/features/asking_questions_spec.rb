require 'rails_helper'

RSpec.describe 'Asking questions' do
  it 'requires users be logged in' do
    visit '/questions/new'

    expect(page).to have_content 'Please sign in to continue.'
  end

  describe 'as a logged in user' do
    before do
      User.create(email: 'test@example.com', password: 'Password123')

      visit '/questions/new'
      fill_in "session[email]", with: 'test@example.com'
      fill_in "session[password]", with: 'Password123'
      click_on "commit"
    end

    it do
      expect {
        visit '/questions/new'

        save_and_open_page
        fill_in "question[title]", with: 'A Question'
        fill_in "question[body]", with: 'Question body'

        click_on "commit"
      }.to change { Question.count }.by(1)
    end
  end
end
