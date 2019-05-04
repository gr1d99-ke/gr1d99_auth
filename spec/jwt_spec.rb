describe Gr1d99Auth do
  let(:name) { "Gideon" }
  let(:algorithm) { 'HS512' }
  let(:key) { "1234" }
  let(:verify) { true }
  let(:exp) { nil }
  let(:config) { described_class::JWTConfig.new(key: key, verify: verify, algorithm: algorithm, exp: exp) }
  let(:payload) { { name: name } }

  it "encodes payload" do
    expect(described_class::JWT.encode(payload, config)).not_to be(blank?)
  end

  it "decodes jwt" do
    token = described_class::JWT.encode(payload, config)
    data = described_class::JWT.decode(token, config)
    payload = data[0]

    expect(payload["name"]).to match(/#{name}/)
  end

  it "raises JWT::ExpiredSignature when token is expired" do
    exp = Time.now.to_i + 1
    config = described_class::JWTConfig.new(key: key, verify: verify, algorithm: algorithm, exp: exp)
    token = described_class::JWT.encode(payload, config)
    sleep(2)

    expect { described_class::JWT.decode(token, config) }.to raise_error(JWT::DecodeError)
  end

  it "raises JWT::VerificationError when invalid key is used" do
    token = described_class::JWT.encode(payload, config)
    invalid_config = described_class::JWTConfig.new(key: "456", verify: verify, algorithm: algorithm, exp: nil)

    expect { described_class::JWT.decode(token, invalid_config) }.to raise_error(JWT::VerificationError)
  end

  it "raises JWT::IncorrectAlgorithm when algorithm is incorrect" do
    token = described_class::JWT.encode(payload, config)
    invalid_config = described_class::JWTConfig.new(key: key, verify: true, algorithm: 'HS256', exp: nil)

    expect { described_class::JWT.decode(token, invalid_config) }.to raise_error(JWT::IncorrectAlgorithm)
  end
end
