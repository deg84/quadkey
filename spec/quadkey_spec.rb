require "spec_helper"

describe Quadkey do
  describe '#encode' do
    context 'latitude: 35.657976, longitude: -139.745364, precision: 16' do
      it "quadkey: '0221130032120022'" do
        expect(Quadkey.encode(35.657976, -139.745364, 16)).to eq('0221130032120022')
      end
    end
  end

  describe '#decode' do
    context "quadkey: '0221130032120022'" do
      it 'latitude: 35.661759419295, longitude: -139.74609375, precision: 16' do
        expect(Quadkey.decode('0221130032120022')).to eq([35.66175941929504, -139.74609375, 16])
      end
    end
  end
end
