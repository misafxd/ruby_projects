# spec/caesar_cipher_spec.rb
require './Caesar_Cipher/lib/caesar_cipher'

describe '#caesar_cipher' do
  it 'shifts lowercase letters correctly' do
    expect(caesar_cipher('Hello, World!', 4)).to eql('Lipps, Asvph!')
  end

  it 'shifts uppercase letters correctly' do
    expect(caesar_cipher('HELLO, WORLD!', 4)).to eq('LIPPS, ASVPH!')
  end

  it 'preserves non-alphabetical characters' do
    expect(caesar_cipher('Hello, 123 World!', 4)).to eq('Lipps, 123 Asvph!')
  end

  it 'shifts letters correctly with negative factors' do
    expect(caesar_cipher('I am negative', -5)).to eq('D vh izbvodqz')
  end

  it 'wraps the shift correctly with a shift factor that exceeds the alphabet' do
    expect(caesar_cipher('Hello, World!', 28)).to eq('Jgnnq, Yqtnf!')
  end
end
