require 'rails_helper'

RSpec.describe "Always Valid Test" do
  subject { User.new(name: 'Test User', photo: 'www.photo.com', bio: 'Test User model') }

  before { subject.name = nil; subject.save }
  
  it 'name should be present' do
    expect(subject).to_not be_valid
  end
end

