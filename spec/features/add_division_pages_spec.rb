require 'rails_helper'

describe "the add a division process" do
  it "adds a new division" do
    visit divisions_path
    click_link 'Create new division'
    click_link 'Sign up'
    fill_in 'user[email]', :with => 'test@epicodus.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'Sign up'
    fill_in 'division[name]', :with => 'HR'
    click_on 'Create Division'
    expect(page).to have_content 'HR division successfully added!'
    expect(page).to have_content 'HR'
  end

  it "gives an error when no name is entered" do
    visit new_division_path
    click_link 'Sign up'
    fill_in 'user[email]', :with => 'test@epicodus.com'
    fill_in 'user[password]', :with => 'password'
    fill_in 'user[password_confirmation]', :with => 'password'
    click_on 'Sign up'
    click_on 'Create Division'
    expect(page).to have_content "Name can't be blank"
  end
end
