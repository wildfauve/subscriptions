require './lib/test_service_1'
require './subscription_structures/test_structure_1'

describe ViewService do

  context 'when replicating the activity-based access functions' do

    it 'allows access to the subject to view the metrics' do
      result = ViewService.new.(policy_context: {current_subject: "/subject/1", subscription: AGRIMETRICS_SUBSCRIPTION})

      expect(result).to be_success
    end

    it 'disallows access to a subject that is not part of the subscription' do
      result = ViewService.new.(policy_context: {current_subject: "/subject/2", subscription: AGRIMETRICS_SUBSCRIPTION})

      expect(result).to be_failure

    end

  end # context

  context 'when scoping the access to specific data contexts' do

    it 'presents (dummy) metrics for the subscribed_to animal groups' do

      result = ViewService.new.(policy_context: {current_subject: "/subject/1", subscription: AGRIMETRICS_SUBSCRIPTION})

      expect(result).to be_success
      expect(result.value).to include("/ag/1", "/ag/2")

    end

  end # context

end # describe
