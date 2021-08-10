require 'rails_helper'

RSpec.describe Flight do
  describe 'relationships' do
    it { should belong_to(:airline) }
    it { should have_many(:trips) }
    it { should have_many(:passengers).through(:trips) }
  end
end
