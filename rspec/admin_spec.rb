require File.expand_path '../spec_helper.rb', __FILE__

feature "admin page" do
	
	scenario "should be accessible at /admin" do
		visit '/admin'
		expect(page).to have_title('Dashboard | 2Chez')
	end

	
end