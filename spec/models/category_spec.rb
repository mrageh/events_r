require 'spec_helper'

describe Category do
  context '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context '#events' do
    it { should have_many(:events).through(:categorisations) }
  end
end
