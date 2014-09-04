require 'spec_helper'

describe Admin do
	before do
	  @admin = Admin.new(name: "Example admin", password: "foobar", password_confirmation: "foobar")
	end	
	subject { @admin }
	it { should respond_to(:id)}
	it { should respond_to(:name) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:authenticate) }
	it { should be_valid }
end
