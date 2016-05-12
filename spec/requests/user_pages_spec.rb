include ApplicationHelper
require 'spec_helper'

describe "User pages" do
	
	subject { page } # makes page the default subject of the test example

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

	# Testing user profile page
	describe "profile page" do
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

		describe "SIGNUP with INVALID information" do
			it "should NOT create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "SIGNUP with VALID information" do
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

    # describe "after saving the user" do
    #   before { click_button submit }
    #   let(:user) { User.find_by(email: 'user@example.com') }

    #   it { should have_link('Sign out') }
    #   it { should have_title(user.name) }
    #   it { should have_selector('div.alert.alert-success', text: 'Welcome') }
    # end

		describe "after submission" do
			before { click_button submit }

			it { should have_title('Signup') }
			it { should have_content('error') }
		end
	end # --- close "signup" ---

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    # before { visit edit_user_path(user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "EDIT with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "EDIT with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

  end # --- close "edit" ---



end