require 'rails_helper'

RSpec.describe Billboard, type: :model do
  it 'has a valid factory' do
    expect(build(:billboard)).to be_valid
  end

  describe '#likes' do
    let(:billboard) { create(:billboard) }
    let(:user) { create(:user) }

    subject { billboard.likes }

    context 'when interactions exist' do
      let!(:billboard_interaction) do
        create(
          :billboard_interaction,
          user: user,
          billboard: billboard,
          reaction: 1
        )
      end

      it 'returns 1' do
        expect(subject).to eq(1)
      end
    end

    context 'when interactions do not exist' do
      it 'returns 0' do
        expect(subject).to eq(0)
      end
    end
  end

  describe '#dislikes' do
    let(:billboard) { create(:billboard) }
    let(:user) { create(:user) }

    subject { billboard.dislikes }

    context 'when interactions exist' do
      let!(:billboard_interaction) do
        create(
          :billboard_interaction,
          user: user,
          billboard: billboard,
          reaction: -1
        )
      end

      it 'returns 1' do
        expect(subject).to eq(1)
      end
    end

    context 'when interactions do not exist' do
      it 'returns 0' do
        expect(subject).to eq(0)
      end
    end
  end
end
