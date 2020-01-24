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

  describe '#ground_resolution' do
    context 'latitude: 35.6684415, precision: 16' do
      it '1.9405565642194964' do
        expect(Quadkey.ground_resolution(35.6684415, 16)).to eq(1.9405565642194964)
      end
    end
  end

  describe '#neighbors' do
    context "quadkey: '133002112310301'" do
      it do
        expect(Quadkey.neighbors('133002112310301')).to eq([
          '133002112310122', '133002112310123', '133002112310132', '133002112310300', '133002112310301', '133002112310310', '133002112310302', '133002112310303', '133002112310312',
        ])
      end
    end
    context "quadkey: '201111111231'" do
      it do
        expect(Quadkey.neighbors('201111111231')).to eq([
          '201111111212', '201111111213', '201111111302', '201111111230', '201111111231', '201111111320', '201111111232', '201111111233', '201111111322',
        ])
      end
    end
  end
end
