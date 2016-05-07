require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "RoR Sample App" }

	describe "Home page" do
		it "should have the content 'Sample App'" do
			visit '/home' # visit 'home' also works
			expect(page).to have_content('Sample App')
		end

		it "should have the base title" do
			visit '/home'
			expect(page).to have_title("#{base_title}")
		end

		it "should not have a custom page title" do
			visit '/home'
			expect(page).not_to have_title('| Home')
		end
	end

	describe "Help page" do
		it "should have the content 'Help'" do
			visit '/help'
			# visit help_path
			expect(page).to have_content('Help')
		end

		it "should have the title 'Help'" do
			visit '/help'
			expect(page).to have_title("Help | #{base_title}")
		end
	end

	describe "About page" do
		it "should have the content 'About Us'" do
			visit '/about'
			# visit 'about'
			# visit about_path
			expect(page).to have_content('About Us')
		end

		it "should have the title 'About'" do
			visit '/about'
			expect(page).to have_title("About | #{base_title}")
		end
	end

	describe "Contact page" do
		it "should have the content 'Contact'" do
			visit '/contact' 
			expect(page).to have_content('Contact')
		end

		it "should have the title 'Contact'" do
			visit '/contact'
			expect(page).to have_title("Contact | #{base_title}")
		end
	end
end