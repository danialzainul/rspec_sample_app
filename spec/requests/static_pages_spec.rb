require 'spec_helper'

describe "Static pages" do

	describe "Home page" do
		it "should have the content 'Sample App'" do
			visit '/home' # visit 'home' also works
			expect(page).to have_content('Sample App')
		end

		it "should have the title 'Home'" do
			visit '/home'
			expect(page).to have_title('Home')
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
			expect(page).to have_title('Help')
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
			expect(page).to have_title('About')
		end
	end


end