require 'spec_helper'

describe 'Rating page' do

  subject { page }
  describe 'page view' do
    before { visit rating_path }
    it { should have_title('Hotels | Rating') }
    it { should have_content('Rating') }
    it { should have_link('Add new hotel',    href: new_hotel_path) }
  end  
end