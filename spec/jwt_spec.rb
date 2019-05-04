describe Gr1d99Auth do
  let(:name) { "Gideon" }
  let(:algorithm) { 'HS512' }
  let(:key) { "1234" }
  let(:verify) { true }
  let(:exp) { nil }
  let(:payload) { { name: name } }

  before do
    described_class.configure do |config|
      config.jwt_key       = key
      config.jwt_verify    = verify
      config.jwt_algorithm = algorithm
      config.jwt_exp       = exp
    end
  end

  it "encodes payload" do
    expect(described_class::JWT.encode(payload)).not_to be(blank?)
  end

  it "decodes jwt" do
    token = described_class::JWT.encode(payload)
    data  = described_class::JWT.decode(token)
    payload = data[0]

    expect(payload["name"]).to match(/#{name}/)
  end

  it "raises JWT::ExpiredSignature when token is expired" do
    described_class.configure do |config|
      config.jwt_key       = key
      config.jwt_verify    = verify
      config.jwt_algorithm = algorithm
      config.jwt_exp       = Time.now.to_i + 1
    end

    token = described_class::JWT.encode(payload)
    sleep(2)

    expect { described_class::JWT.decode(token) }.to raise_error(JWT::DecodeError)
  end

  it "raises JWT::VerificationError when invalid key is used" do
    token = described_class::JWT.encode(payload)
    described_class::configure do |config|
      config.jwt_key       = "456"
      config.jwt_verify    = verify
      config.jwt_algorithm = algorithm
      config.jwt_exp       = nil
    end

    expect { described_class::JWT.decode(token) }.to raise_error(JWT::VerificationError)
  end

  it "raises JWT::IncorrectAlgorithm when algorithm is incorrect" do
    token = described_class::JWT.encode(payload)
    described_class.configure do |config|
      config.jwt_key       = key
      config.jwt_verify    = true
      config.jwt_algorithm = 'HS256'
      config.jwt_exp       = nil
    end

    expect { described_class::JWT.decode(token) }.to raise_error(JWT::IncorrectAlgorithm)
  end
end
