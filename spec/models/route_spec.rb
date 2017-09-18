require "rails_helper"
RSpec.describe Route, type: :model do
  it { is_expected.to be_mongoid_document }

  describe 'validations' do
    it 'validates passfrase' do
      expect{Route.new( passphrase: '1').save!}.to raise_error(Mongoid::Errors::Validations)
    end

    it 'validates start_node' do
      expect{Route.create!( start_node: '1')}.to raise_error(Mongoid::Errors::Validations)
    end

    it 'validates end_node' do
      expect{Route.new( end_node: '').save!}.to raise_error(Mongoid::Errors::Validations)
    end
  end

  describe 'saves the model' do
    it 'saves the document' do
      route = Route.new(id: 1,
                        passphrase: 'Kans4s-i$-g01ng-by3-bye',
                        source: 'sentinels',
                        start_node: 'alpha',
                        end_node: 'beta',
                        start_time: DateTime.now,
                        end_time: DateTime.now + 5)
      expect(route.save!).to be_truthy
    end
  end

  #TODO test scope
end