require 'spec_helper'

describe Address do
  before do
    @address = Address.new(country: "Russia", state: "ARC", city: "Sevastopol", street: "Centr, 25")
  end

  subject { @address }

  it { should respond_to(:country) }
  it { should respond_to(:state) }
  it { should respond_to(:city) }
  it { should respond_to(:street) }
    
  it { should be_valid }

  describe "when country is not present" do
    before { @address.country = " " }
    it { should_not be_valid }
  end

  describe "when city is not present" do
    before { @address.city = " " }
    it { should_not be_valid }
  end

  describe "when stree is not present" do
    before { @address.street = " " }
    it { should_not be_valid }
  end
end