require 'rails_helper'

RSpec.describe Style, :type => :model do

  it "without a name is not valid" do
    style = Style.create  description:"Tällä tyylillä ei ole nimeä"

    style.should_not be_valid
  end

end
