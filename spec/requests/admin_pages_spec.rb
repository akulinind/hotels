require 'spec_helper'

describe "AdminPages" do
	subject { page }
	User.delete_all
	Hotel.delete_all
	5.times { FactoryGirl.create(:user) }
	10.times { FactoryGirl.create(:hotel)}
	#	{	5.times { FactoryGirl.create(:hotel, user_id: Random.rand(1..5))} }
  describe "Enter to the page" do
  	let(:admin) { FactoryGirl.create(:admin) }
    before { visit new_admins_session_path }
	  describe "it is right page?" do
	    it { should have_title("Admin Panel") }
	    it { should have_content('Sign in') }
	    it { should have_button ('Admin Sign in') }
		end
		describe "Inccorect user try to login" do
			before { click_button "Sign in" }
			it { should have_content('Sign in') }
			it { should have_button ('Admin Sign in') }	
		end
		describe "Correct user try to login" do
			before do 
				fill_in "Name",    with: admin.name
				fill_in "Password", with: admin.password
				click_button "Admin Sign in"
			end
	    it { should have_content('Admin Panel') }
			it { should have_link('End admin session') }
			it { should_not have_button('Admin Sign in') }

			describe "Is it management of users?" do
				it { should have_content('Filter by name or email:')}
				it { should have_link('Manage hotels')}
#				it { should have_table('Users table') }
				it "Should list each user" do
				  User.all.each do |user|
				    expect(page).to have_selector('td', text: user.id)
				    expect(page).to have_selector('td', text: user.name)
				    expect(page).to have_selector('td', text: user.email)
				    expect(page).to have_selector('td', text: user.hotels.count)
				    expect(page).to have_selector('td', text: user.rates.count)
				  end
				end
			describe "Sorting?" do
#don't test well
				before do
				  click_link 'name'
				end
				it { should have_link ("name")}
				it 'Should sort by name' do
					users = User.all.name_asc
					  users.each do |user|
						  expect(page).to have_selector('td', text: user.name)
					  end
				end
				it 'Should desc sort by name' do
					users = User.all.name_desc
					  users.each do |user|
						  expect(page).to have_selector('td', text: user.name)
					  end
				end

			end
			describe "Filter?" do
				describe "Incorrect search" do
					before do
						fill_in "search", with: "example532"
						click_button "Search"
					end
					it { should_not have_selector('td', text: "example")}
				end
				describe "Correct search email" do
					before do
						fill_in "search", with: "1@example.com"
						click_button "Search"
					end
					it { should have_selector('td', text: "1@example.com")}
					it { should_not have_selector('td', text: "2@example.com")}
				end
				describe "Correct search login" do
					before do
						fill_in "search", with: "Person 1"
						click_button "Search"
					end
					it { should have_selector('td', text: "Person 1")}
					it { should_not have_selector('td', text: "Person 2")}
				end

				end
				describe "Edit users" do
						before { first(:link, "edit").click }
						it { should have_title "Edit user" }
						it { should have_content "Name" }
#						it { should have_selector "Person"}
				end
				describe "Delete users" do
					it 'Should delete user' do
					  expect {first('tr').click_link('delete')}.to change(User, :count).by(-1)
					end
				end

				describe "Add users" do
					before { click_link "Add user"}
					it { should have_title "Sign up"}
				end


				describe "Hotel management" do
					before { click_link "Manage hotels" }
					it { should have_content "Filter by status:"}
					it "Should list each user" do
					  Hotel.all.each do |hotel|
					    expect(page).to have_selector('td', text: hotel.id)
					    expect(page).to have_selector('td', text: hotel.title)
					    expect(page).to have_selector('td', text: hotel.rate_avg)
					    expect(page).to have_selector('td', text: hotel.stars)
					    expect(page).to have_selector('td', text: hotel.status)
					  end
					expect(page).to have_selector('td', text: "pending")
					expect(page).to have_selector('td', text: "approved")
					expect(page).to have_selector('td', text: "rejected")

  
					end
					describe "Filter by status?" do
						describe "Status:approved" do
								before do
									select "approved", :from => :search 
									click_button "Search"
								end						
							it { should have_content "Filter by status:"}
							it { should have_selector('td', text: "approved")}
							it { should_not have_selector('td', text: "rejected")}
							it { should_not have_selector('td', text: "pending")}
						end
						describe "Status:pending" do
								before do
									select "pending", :from => :search 
									click_button "Search"
								end						
							it { should have_content "Filter by status:"}
							it { should_not have_selector('td', text: "approved")}
							it { should_not have_selector('td', text: "rejected")}
							it { should have_selector('td', text: "pending")}
						end
						describe "Status:rejected" do
								before do
									select "rejected", :from => :search 
									click_button "Search"
								end						
							it { should have_content "Filter by status:"}
							it { should_not have_selector('td', text: "approved")}
							it { should have_selector('td', text: "rejected")}
							it { should_not have_selector('td', text: "pending")}
						end
						describe "Status:all?" do
								before do
									select "All", :from => :search 
									click_button "Search"
								end						
							it { should have_content "Filter by status:"}
							it { should have_selector('td', text: "approved")}
							it { should have_selector('td', text: "rejected")}
							it { should have_selector('td', text: "pending")}
						end
					end
					describe "Change status and ActionMailer" do


						it { expect {first(:link, "approve").click}.to change(Hotel.where("status='pending'"), :count).by(-1)}
						it { expect {first(:link, "approve").click}.to change { ActionMailer::Base.deliveries.count }.by(1)}

						it { expect {first(:link, "rejecte").click}.to change(Hotel.where("status='pending'"), :count).by(-1)}
						it { expect {first(:link, "rejecte").click}.to change { ActionMailer::Base.deliveries.count }.by(1)}


					end
					
				end
			end	

			describe "Logout admin" do
  			    before { click_link "End admin session" }
						it { should_not have_link('End admin session') }
						it { should_not have_content('Filter by name or email:')}
  			   	it {should have_content ('Top 5')}
			end
		end

  end

 



end

