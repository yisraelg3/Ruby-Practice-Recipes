require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { should have_many(:instructions).dependent(:destroy) }
  it { should have_many(:ingredients).dependent(:destroy) }

  it { should validate_presence_of(:name)}
end
