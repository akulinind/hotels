require 'spec_helper'


describe "Static_pages" do
	describe "Home page" do
		it "should have the content 'Hotels'" do
			visit '/static_pages/home'
			expect(page).to have_content('Hotels')
		end
		it "should have the base title" do
			visit '/static_pages/home'
			expect(page).to have_title('Hotels') 
		end
		it "should have a custom title" do
			visit '/static_pages/home'
			expect(page).not_to have_title('Home')
		end
	end

end
