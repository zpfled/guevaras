require File.expand_path '../spec_helper.rb', __FILE__

describe "Signup page" do
  it "should be accessible at '/signup'" do
    get '/signup'
    last_response.should be_ok
  end

  it "should create a new Manager on 'submit'" do
    visit '/signup'
    fill_in 'name',  with: 'Bill Brasky'
    fill_in 'email', with: 'billbrasky@email.com'
    fill_in 'password', with: 'password'
    click_button 'submit'

    user = Manager.first
    expect(user.name).to eq('Bill Brasky')
    expect(user.email).to eq('billbrasky@email.com')
    expect(user.password).to eq('password')
    expect(Manager.all.length).to eq(1)
    expect(user.admin).to eq(false)
  end


end