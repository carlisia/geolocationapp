require 'spec_helper'

describe Location do
  it "has a valid factory" do
    expect(build(:location)).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  
end