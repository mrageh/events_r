require 'spec_helper'

describe Categorisation do
  context '#event' do
    it { should belong_to(:event) }
  end

  context '#category' do
    it { should belong_to(:category) }
  end
end
