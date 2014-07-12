require 'spec_helper'


describe "Static_pages" do
	describe "Home page" do
		it "should have the content 'Hotels'" do
			visit '/static_pages/home'
			expect(page).to have_content('Hotels')
		end
		it "should have th right title" do
			visit '/static_pages/home'
			expect(page).to have_title('Hotels') 
		end
	end

end
