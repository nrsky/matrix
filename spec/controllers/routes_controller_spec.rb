require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  describe '/routes' do
    it 'GET loopholes' do
      VCR.use_cassette("loopholes", :record => :new_episodes) do
        post :download, params: { source: 'loopholes', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
        expect(response.status).to eq(200)
      end
    end

    it 'GET sentinels' do
      VCR.use_cassette("sentinels", :record => :new_episodes) do
        post :download, params: { source: 'sentinels', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
        expect(response.status).to eq(200)
      end
    end

    it 'GET sniffers' do
      VCR.use_cassette("sniffers", :record => :new_episodes) do
        post :download, params: { source: 'sniffers', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
        expect(response.status).to eq(200)
      end
    end

    #TODO
    #1) write VCR cassette to record scenario without passphrase and/or source provided
    #2) add test for strong params without source
    #3) add test for strong params without passphrase
  end

  describe 'upload routes' do
    let!(:route){ FactoryGirl.create(:route, source: 'loopholes') }
    let!(:route){ FactoryGirl.create(:route, source: 'sentinels') }
    let!(:route){ FactoryGirl.create(:route, source: 'sniffers') }

    it 'POST loopholes' do
      post :upload, params: { source: 'loopholes', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      expect(response.status).to eq(200)
    end

    it 'POST sentinels' do
      post :upload, params: { source: 'sentinels', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      expect(response.status).to eq(200)
    end

    it 'POST sniffers' do
      post :upload, params: { source: 'sniffers', passphrase: 'Kans4s-i$-g01ng-by3-bye' }
      expect(response.status).to eq(200)
    end

    #TODO
    #1) add test for strong params without source
    #2) add test for strong params without passphrase
  end
end
