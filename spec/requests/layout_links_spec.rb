require 'spec_helper'

describe "LayoutLinks" do
  
  it "should show home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should show about page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  
  it "should show help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "should show contact page at '/contact" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  
  it "sign up should be found at '/signup'" do
      get '/signup'
      response.should have_selector("title", :content => "Sign up")
  end
end
