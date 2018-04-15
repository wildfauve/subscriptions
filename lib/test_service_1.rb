require 'pry'
require 'dry-monads'

class ViewService

  include Dry::Monads::Either::Mixin

  CAPABILITY = "urn:lic:sub:agri_metrics:cap:animal_movements"

  # Can this subject access this service?
  def call(policy_context:)
    # Policy Decision:
    # + the subject is allowed access to the subscription
    # + the subscription is allowed access to the capability
    policy_decision = authz.new.policy_decision(CAPABILITY, policy_context)
    return policy_decision unless policy_decision.success?

    # Scope request by subscription resources
    dummy_animal_groups_find(policy_context[:subscription])
  end

  private

  def dummy_animal_groups_find(subscription)
    Right(subscription[:resources][:animal_groups])
  end

  def authz
    Authorisation
  end

end


class Authorisation

  include Dry::Monads::Either::Mixin

  def policy_decision(capability, policy_context)
    Fn.compose
      .(to_maybe_fn, Fn.all?.(success_fn)).(decision_chain(capability, policy_context))
  end

  private

  def decision_chain(capability, policy_context)
    [ has_subject(policy_context), has_capability(capability, policy_context) ]
  end

  def has_subject(policy_context)
    Fn.compose.(to_maybe_fn, subject_fn(policy_context[:current_subject]))
              .(policy_context[:subscription][:subjects])
  end

  def subject_fn(current_subject)
    Fn.find.(subject_match_fn(current_subject))
  end

  def subject_match_fn(current_subject)
    ->(e) { e == current_subject }
  end

  def has_capability(capability, policy_context)
    Fn.compose.(to_maybe_fn, has_capability_fn(capability)).(policy_context[:subscription][:capabilities])
  end

  def has_capability_fn(capability)
    Fn.find.(capability_match_fn(capability))
  end

  def capability_match_fn(capability)
    ->(e) { e == capability }
  end

  def to_maybe_fn
    ->(result) { result ? Right(result) : Left(result) }
  end

  def success_fn
    ->(e) { e.success? }
  end


end
