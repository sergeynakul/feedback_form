# frozen_string_literal: true

require File.expand_path 'acceptance_helper.rb', __dir__

feature 'My Sinatra Application' do
  scenario "should have button 'Send Message' on the home page" do
    visit '/'
    expect(page).to have_button('Send Message')
  end
end
