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

	# Testing user signup page
	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Signup') }
		it { should have_title(full_title('Signup')) }
	end

	describe "signup" do
		before { visit signup_path }

		let(:submit) { "Create my account" } 

		describe "with INVALID information" do
			it "should NOT create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with VALID information" do
			before do
				fill_in "Name", 		with: "Example User"
				fill_in "Email", 		with: "user@example.com"
				fill_in "Password", with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

		end
	end

end