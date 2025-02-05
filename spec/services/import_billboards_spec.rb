require 'rails_helper'

RSpec.describe ImportBillboards do

  describe '#call' do
    subject do 
      described_class.new(csv_uploa_id).call
    end

    context 'when csv upload object is invalid' do
      let(:csv_uploa_id) { 0 }

      it 'raise an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when csv upload object is valid' do
      let(:csv_upload) { create(:csv_upload) }
      let(:csv_uploa_id) { csv_upload.id }
      
      it 'set the status to success' do
        subject
        expect(csv_upload.reload).to be_success
      end

      it 'creates a billboard object' do
        expect {subject}.to change { Billboard.count }.by(1)
      end
    end
  end
end