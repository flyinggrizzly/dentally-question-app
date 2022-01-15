require 'rails_helper'

RSpec.describe User do
  describe 'destroying users destroys their questions' do
    it do
      user = User.create(email: 'test@example.com', password: 'Password123')

      question_id = user.questions.create(title: 'Question 1', body: 'What is speed of a swallow?').id

      expect(Question.find(question_id).title).to eq('Question 1')

      user.destroy

      expect {
        Question.find(question_id)
      }.to raise_error("Couldn't find Question with 'id'=#{question_id}")
    end
  end
end

