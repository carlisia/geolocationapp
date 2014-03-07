require 'spec_helper'

feature 'View the homepage' do 
  scenario 'user sees homepage title' do
    visit root_path
    page.has_title? 'Geolocation App'
  end
end

