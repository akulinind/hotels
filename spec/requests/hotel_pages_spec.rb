require 'spec_helper'

describe 'Add new hotel page: ' do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  context 'not signed in user' do
    before { get new_hotel_path }
    specify { expect(response).to redirect_to(signin_path) }
  end
  context 'signed in user' do
    before do
          visit signin_path
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
      visit new_hotel_path
    end

    describe 'form' do
      it{ should have_title 'Hotels | Add new Hotel' }
      it{ should have_content 'Add new Hotel'}
      it{ should have_field 'Title'}
      it{ should have_field 'Stars'}
      it{ should have_field 'Breakfast'}
      it{ should have_field 'Description'}
      it{ should have_field 'Price'}
      it{ should have_field 'Photo'}
      it{ should have_field 'Country'}
      it{ should have_field 'City'}
      it{ should have_field 'State'}
      it{ should have_field 'Street'}
      it{ should have_field 'Street'}
      it{ should have_button 'Save'}
    end

    describe 'creates new hotel' do
      context 'with invalid data' do
        describe 'error message' do
          before do
            click_button 'Save'
          end
          it { should have_selector('div.alert.alert-error') }
        end
        it "should not create a hotel" do
          expect { click_button "Save" }.not_to change(Hotel, :count)
        end
      end

      context 'with valid data' do
        let(:title) { 'Example Hotel' }
        let(:stars) { 5 }
        let(:breakfast) { true }
        let(:photo) { 'hotel_default.jpg'  }
        let(:description) { 'description' }
        let(:price) { 500 }
        let(:country) { 'Example' }
        let(:state) { 'Example' }
        let(:city) { 'Example' }
        let(:street) { 'Example'}
        before do
          fill_in 'Title', with: title
          select stars.to_s, from: 'Stars'
          check 'Breakfast'
          fill_in 'Description', with: description
          fill_in 'Price', with: price
          fill_in 'Country', with: country
          fill_in 'State', with: state
          fill_in 'City', with: city
          fill_in 'Street', with: street
        end
        it "should create a hotel" do
          expect { click_button "Save" }.to change(Hotel, :count).by(1)
        end  
      end
      context 'with invalid data' do
        let(:title) { 'Example Hotel' }
        let(:stars) { 5 }
        let(:breakfast) { true }
        let(:photo) { 'hotel_default.jpg'  }
        let(:description) { 'description' }
        let(:price) { "trista" }
        let(:country) { 'Example' }
        let(:state) { 'Example' }
        let(:city) { 'Example' }
        let(:street) { 'Example'}
        before do
          fill_in 'Title', with: title
          select stars.to_s, from: 'Stars'
          check 'Breakfast'
          fill_in 'Description', with: description
          fill_in 'Price', with: price
          fill_in 'Country', with: country
          fill_in 'State', with: state
          fill_in 'City', with: city
          fill_in 'Street', with: street
        end
        it "should not create a hotel" do
          expect { click_button "Save" }.not_to change(Hotel, :count)
        end
        
      end
    end
  end
end