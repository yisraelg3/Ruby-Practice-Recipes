require 'rails_helper'

RSpec.describe Instruction, type: :model do
  it { should belong_to(:recipe)}

  it { should validate_presence_of(:step) }
end
