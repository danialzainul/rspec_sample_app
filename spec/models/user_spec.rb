require 'spec_helper'

describe User do

	before { @user = User.new(name: "Example User", email: "user@example.com") }	
	subject { @user } # makes @user the default subject of the test example
	# because of subject { @user }, we can alternatively write this using the single-line style 

	it { should respond_to(:name) }
	it { should respond_to(:email) }

	it { should be_valid }

	# testing for presence
	describe "when user name is NOT present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when user email is NOT present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	# testing for length
	describe "when user name is too long" do
		before { @user.name = "a" * 51 } # name is 51 characters
		it { should_not be_valid }
	end

	# testing email validity
	describe "when email format is VALID" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when email format is INVALID" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

end