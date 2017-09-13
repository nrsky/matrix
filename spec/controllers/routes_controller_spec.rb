require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  before {
    # controller_stub_token_authentication
  }
  let(:valid_session) { {} }

  describe '/routes' do
    it 'GET loopholes' do
      post :index, params: { source: 'loopholes', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
    end

    it 'GET sentinels' do
      post :index, params: { source: 'sentinels', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
    end

    it 'GET sniffers' do
      post :index, params: { source: 'sniffers', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
    end
  end
end
