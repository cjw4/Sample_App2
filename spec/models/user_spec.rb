require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Chris Walker",
              :email => "cjw7488@gmail.com",
              :password => "foobar",
              :confirm_password => "foobar" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.create(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email" do
    no_email_user = User.create(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    longname_user = User.create(@attr.merge(:name => long_name))
    longname_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject a duplicate email address" do
    User.create!(@attr)
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should reject emails identical up to case" do
    User.create!(@attr)
    upcase_email = @attr[:email].upcase
    duplicate_email_user = User.new(@attr.merge(:email => upcase_email))
    duplicate_email_user.should_not be_valid
  end
  
  describe "password validations" do
  
    it "should require a password" do
      no_password_user = User.new(@attr.merge(:password => "", :confirm_password => ""))
      no_password_user.should_not be_valid
    end
  
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:confirm_password => "invalid")).should_not be_valid
    end
  
    it "shoud reject short passwords" do
      short_password = "a" * 4
      User.new(@attr.merge(:password => short_password, :confirm_password => short_password)).should_not be_valid
    end
  
    it "should reject long passwords" do
      long_password = "a" * 41
      User.new(@attr.merge(:password => long_password, :confirm_password => long_password)).should_not be_valid
    end
  end
  
  describe "password encryption" do
  
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the password encryption" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should be true if password match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
  end
end
