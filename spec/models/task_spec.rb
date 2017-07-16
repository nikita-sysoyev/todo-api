require 'rails_helper'

# Test suite for the Task model
RSpec.describe Task, type: :model do
  # Association test
  # ensure an item record belongs to a single board record
  it { should belong_to(:board) }
  #it { should validate_presence_of(:name) }
end