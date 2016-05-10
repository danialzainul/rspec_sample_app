include ApplicationHelper
require 'spec_helper'

describe "User pages" do
	
	subject { page } # makes page the default subject of the test example

	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Signup') }
		it { should have_title(full_title('Signup')) }
		# OR it { should have_title('Signup') }
	end

	# Testing user profile page
	describe "profile page" do
		# byebug
		# let(:user) { User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
	end

end