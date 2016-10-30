FactoryGirl.define do

  factory :event do
      title 'an event'
      creator { User.first }

      factory :another_event do
        title 'another event'
      end

      factory :active_event do
        title 'an active event'
        state StateMachine::ACTIVE
      end
  end

end
