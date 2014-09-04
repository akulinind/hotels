require 'spec_helper'


describe "Static_pages" do

  describe "Home page" do
  	it "should have the content 'Hotels'" do
      visit  root_path
      expect(page).to have_content('Hotels')
		end
		it "should have the base title" do
		  visit root_path
		  expect(page).to have_title('Hotels') 
		end
		it "should have a custom title" do
		  visit root_path
		  expect(page).not_to have_title('Home')
		end

	end
  
  describe "for non-signed users" do
  	it "should not have links" do
	 		visit root_path
	 		expect(page).not_to have_link("Sign out")
	 		expect(page).not_to have_link("Edite Profile")
	 		expect(page).not_to have_link("Add Hotel")

	 	end
	end
  
  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit root_path
      it "should have a right links" do
				visit root_path
				expect(page).to have_link("Add Hotel")
				expect(page).to have_link("Sign Out")
				expect(page).not_to have_link("Edite Profile")
	  	end
    end

	end
end
