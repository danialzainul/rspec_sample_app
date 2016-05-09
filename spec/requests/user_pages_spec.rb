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

end