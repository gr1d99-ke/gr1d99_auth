describe Gr1d99Auth::Helpers do
  class User
    def self.find_by(*); end
  end

  class TestController
    include Gr1d99Auth::Helpers
    def request; end
  end

  def setup_configuration
    algorithm = "HS512"
    key       = "1234"
    verify    = true

    Gr1d99Auth.configure do |config|
      config.jwt_key       = key
      config.jwt_verify    = verify
      config.jwt_algorithm = algorithm
    end
  end

  describe ".generate_token" do
    before { setup_configuration }

    it "returns jwt token" do
      expect(!TestController.new.generate_token(1).blank?).to be_truthy
    end
  end

  describe ".authenticate" do
    let(:authorization_header) { { "HTTP_AUTHORIZATION" => "Bearer user.jwt.token" } }
    let(:request)              { instance_double("Request") }
    let(:user)                 { double("user") }

    it "sets current user instance" do
      allow_any_instance_of(TestController).to receive(:request) { request }
      allow(request).to receive(:env)     { authorization_header }
      allow(::JWT).to   receive(:decode)  { [{ "user_id": 1 }] }
      allow(User).to    receive(:find_by) { user }

      controller = TestController.new
      controller.authenticate
      current_user = controller.instance_variable_get(:"@current_user")

      expect(current_user).not_to be_nil
      expect(current_user).to     be(user)
    end
  end

  describe "helpers" do

  end
end
