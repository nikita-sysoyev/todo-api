# spec/models/board_spec.rb
require 'rails_helper'

# Test suite for the Board model
RSpec.describe Board, type: :model do
  # Association test
  # ensure Board model has a 1:m relationship with the Task model
  it { should have_many(:tasks).dependent(:destroy) }
  #it { should validate_presence_of(:title) }
  #it { should validate_presence_of(:description) }
end