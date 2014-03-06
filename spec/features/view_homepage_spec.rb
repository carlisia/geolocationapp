require 'spec_helper'

feature 'View the homepage' do 
  scenario 'user sees relevant information' do
    visit root_path
    page.has_content? 'Geolocation App'
  end
end

