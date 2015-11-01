describe UserController do
  include_context 'dynamo' do
    let(:table) { [build(:user_table), build(:token_table)] }
  end

  let(:orm) { ROM.env }

  let(:rel) { orm.relation(:users) }

  let(:user) { build(:user) }

  subject { response }

  describe 'POST: /register' do
    let(:root) { '/register' }

    before { post root, user.to_h }

    specify { expect_json_types :object }

    specify { expect_status 201 }

    describe 'when a required parameter is missing' do
      [:username, :password].each do |key|
        describe "missing :#{key}" do

          let(:payload) do
            payload = user.to_h
            payload.delete(key)
            payload
          end

          before { post root, payload }

          specify { expect_status 400 }
        end
      end
    end

    describe 'when a user already exists' do
      before { post root, user.to_h }

      specify { expect_status 409 }
    end
  end

  describe 'POST: /login' do
    let(:root) { '/login' }

    before { post '/register', user.to_h }

    describe 'when a user exists' do
      describe 'with correct credentials' do
        before { post root, user.to_h }

        specify { expect_json_types :object }

        specify { expect_status 200 }

        specify { expect(json_body.keys).to include :token, :identity, :expires }
      end

      describe 'with incorrect credentials' do
        before { post root, user.to_h.merge(password: Faker::Internet.password) }

        specify { expect_status 403 }
      end
    end

    describe 'when a user does not exist' do
      let(:fake_user) { build(:user) }

      before { post root, fake_user.to_h }

      specify { expect_status 403 }
    end
  end

  describe 'PUT: /change' do
    let(:root) { '/change' }

    describe 'when a user exists' do
      before { post '/register', user.to_h }

      describe 'with correct credentials' do
        describe 'with a valid new password' do
          let(:payload) {
            {
              username: user.username,
              password: {
                new: Faker::Internet.password,
                old: user.password
              }
            }
          }

          before { put root, payload }

          specify { expect_status 200 }
        end

        describe 'with an invalid new password' do
          let(:payload) {
            {
              username: user.username,
              password: {
                new: '',
                old: user.password
              }
            }
          }

          before { put root, payload }

          specify { expect_status 400 }
        end
      end

      describe 'with incorrect credentials' do
        let(:payload) {
          {
            username: user.username,
            password: {
              new: Faker::Internet.password,
              old: user.password.reverse
            }
          }
        }

        before { put root, payload }

        specify { expect_status 403 }
      end
    end

    describe 'when a user does not exist' do
      let(:payload) {
        {
          username: user.username,
          password: {
            new: Faker::Internet.password,
            old: user.password.reverse
          }
        }
      }

      before { put root, payload }

      specify { expect_status 403 }
    end
  end

  describe 'GET: /lost' do
    let(:root) { '/lost' }

    describe 'when a user exists' do
      before { post '/register', user.to_h }

      before { get "#{root}?username=#{user.username}" }

      specify { expect_status 200 }
    end

    describe 'when a user does not exist' do
      before { get "#{root}?username=#{SecureRandom.uuid}" }

      specify { expect_status 200 }
    end
  end

  describe 'POST: /recover' do
    let(:root) { '/recover' }

    let(:user) { build(:user) }

    let(:token) { build(:token, username: user.username) }

    before { orm.command(:tokens).create.call(token) }

    describe 'when a user exists' do
      before { post '/register', user.to_h }

      describe 'with correct credentials' do
        describe 'with a valid token' do
          let(:payload) do
            {
              token: token.token,
              password: { new: Faker::Internet.password }
            }
          end

          before { post root, payload }

          specify { expect_status 200 }
        end

        describe 'with an invalid token' do
          let(:payload) do
            {
              token: token.token.reverse,
              password: { new: Faker::Internet.password }
            }
          end

          before { post root, payload }

          specify { expect_status 403 }
        end

        describe 'with an invalid token expiry time' do
          let(:token) { build(:token, username: user.username, expires_at: Time.now.utc.to_i - 3600 * 24) }

          let(:payload) do
            {
              token: token.token,
              password: { new: Faker::Internet.password }
            }
          end

          before { post root, payload }

          specify { expect_status 403 }
        end

        describe 'with an invalid new password' do
          let(:payload) do
            {
              token: token.token,
              password: { new: '' }
            }
          end

          before { post root, payload }

          specify { expect_status 400 }
        end
      end
    end

    describe 'when a user does not exist' do
      let(:payload) do
        {
          token: 'ada6a6ayafada245taaa',
          password: { new: Faker::Internet.password }
        }
      end

      before { post root, payload }

      specify { expect_status 403 }
    end
  end
end
