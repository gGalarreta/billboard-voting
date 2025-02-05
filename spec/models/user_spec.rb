require 'rails_helper'

RSpec.describe User, type: :model do
    
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  context 'with enums' do
    describe 'status' do
      let(:roles) do
        {
          'user' => 0,
          'admin' => 1
        }
      end

      it 'has the correct enum values' do
        expect(
          described_class.roles
        ).to eq(roles)
      end
    end
  end
end