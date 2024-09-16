# frozen_string_literal: true

module AUCoreTestKit
  module AssertHelpers
    extend Forwardable

    def_delegators 'properties',
                   :conditional_skip_with_msg,
                   :skip_with_msg

    def act_if_with_message(act_func, condition, message)
      info message if condition

      act_func.call(condition, message)
    end

    def act_with_message(act_func, message)
      info message

      act_func.call(message)
    end

    def conditional_skip_with_msg(condition, message)
      act_if_with_message(method(:skip_if), condition, message)
    end

    def skip_with_msg(message)
      act_with_message(method(:skip), message)
    end
  end
end
