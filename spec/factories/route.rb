FactoryGirl.define do
  factory :route do
    passphrase { (0..22).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    source { ['sentinels', 'sniffers', 'loopholes'].sample }
    start_node { ['alpha', 'beta', 'gamma', 'delta', 'theta', 'lambda', 'tau', 'psi', 'omega'].sample }
    end_node { ['alpha', 'beta', 'gamma', 'delta', 'theta', 'lambda', 'tau', 'psi', 'omega'].sample }
    start_time { Time.now + 1.week }
    end_time { Time.now + 1.week + 1.hour }
  end
end
