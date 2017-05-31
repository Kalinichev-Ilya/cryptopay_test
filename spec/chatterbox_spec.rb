require 'rspec'
require_relative '../app/chatterbox'

RSpec.describe 'Chatterbox' do
  let(:chatterbox) {Chatterbox.new}
  describe '.exchange_transfer' do

    context 'when the account amount allows you to make a transfer' do
      let(:response) {chatterbox.exchange_transfer(1, :USD, :EUR)}
      it {expect(response.code).to eq 201}

    end

    context 'when there is enough amount money' do
      let(:response) {chatterbox.exchange_transfer(500000, :USD, :EUR)}
      it {expect(response.code).to eq 422}
    end

    context 'when amount not valid' do
      let(:response) {chatterbox.exchange_transfer('', :USD, :EUR)}
      it {expect(response.code).to eq 422}

      subject(:error) {JSON.parse(response.body)['amount']}
      it {expect(error.join(',')).to include('must be greater than')}
    end
  end
end
