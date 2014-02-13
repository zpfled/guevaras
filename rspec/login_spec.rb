require File.expand_path '../spec_helper.rb', __FILE__

describe "Login page" do
	it "should be accessible at '/login'" do
		get '/login'
		last_response.should be_ok
	end

end