require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  before {
    # controller_stub_token_authentication
  }

  describe '/routes' do
    it 'GET loopholes' do
      VCR.use_cassette("loopholes", :record => :new_episodes) do
        post :index, params: { source: 'loopholes', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      end
    end

    it 'GET sentinels' do
      VCR.use_cassette("sentinels", :record => :new_episodes) do
        post :index, params: { source: 'sentinels', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      end
    end

    it 'GET sniffers' do
      VCR.use_cassette("sentinels", :record => :new_episodes) do
        post :index, params: { source: 'sniffers', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      end
    end
  end
end
