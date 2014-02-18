require File.expand_path '../spec_helper.rb', __FILE__

feature "admin page" do

	feature "for not-logged-in users" do
		background do
			Manager.create(name: 'Todd', email: 'todd@email.com', password: 'foobar')
		end

		scenario "should redirect them to '/'" do
			visit '/admin'
			expect(page).to have_title('Login | 2Chez')
		end
	end
	
	feature "for logged in users" do

		background do
			Manager.create(name: 'Todd', email: 'todd@email.com', password: 'foobar')
			visit '/login'
			within('#form') do
				fill_in 'name', 	with: 'Todd'
				fill_in 'password', with: 'foobar'
			end
			click_button 'submit'
		end

		scenario "should be accessible at /admin" do
			visit '/admin'
			expect(page).to have_title('Dashboard | 2Chez')
		end
	end
end