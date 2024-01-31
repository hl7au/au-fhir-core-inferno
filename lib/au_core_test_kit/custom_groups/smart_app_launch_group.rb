require 'smart_app_launch_test_kit'
require_relative '../us_core_options'

module USCoreTestKit
  class SmartAppLaunchGroup < Inferno::TestGroup
    id :us_core_smart_app_launch
    title 'SMART App Launch'

    group do
      required_suite_options USCoreOptions::SMART_1_REQUIREMENT
      id :us_core_smart_standalone_launch_stu1
      title 'Standalone Launch'
      optional

      group from: :smart_discovery,
            run_as_group: true
      group from: :smart_standalone_launch,
            run_as_group: true

      group from: :smart_openid_connect do
        run_as_group
        optional
        config(
          inputs: {
            id_token: { name: :standalone_id_token },
            client_id: { name: :standalone_client_id },
            requested_scopes: { name: :standalone_requested_scopes },
            access_token: { name: :standalone_access_token },
            smart_credentials: { name: :standalone_smart_credentials }
          }
        )
      end

      group from: :smart_token_refresh do
        run_as_group
        optional
        config(
          inputs: {
            refresh_token: { name: :standalone_refresh_token },
            client_id: { name: :standalone_client_id },
            client_secret: { name: :standalone_client_secret },
            received_scopes: { name: :standalone_received_scopes }
          }
        )
      end
    end

    group do
      required_suite_options USCoreOptions::SMART_1_REQUIREMENT
      id :us_core_smart_ehr_launch_stu1
      title 'EHR Launch'
      optional

      group from: :smart_discovery,
            run_as_group: true
      group from: :smart_ehr_launch,
            run_as_group: true

      group from: :smart_openid_connect do
        run_as_group
        optional
        config(
          inputs: {
            id_token: { name: :ehr_id_token },
            client_id: { name: :ehr_client_id },
            requested_scopes: { name: :ehr_requested_scopes },
            access_token: { name: :ehr_access_token },
            smart_credentials: { name: :ehr_smart_credentials }
          }
        )
      end

      group from: :smart_token_refresh do
        run_as_group
        optional
        config(
          inputs: {
            refresh_token: { name: :ehr_refresh_token },
            client_id: { name: :ehr_client_id },
            client_secret: { name: :ehr_client_secret },
            received_scopes: { name: :ehr_received_scopes }
          }
        )
      end
    end

    group do
      required_suite_options USCoreOptions::SMART_2_REQUIREMENT
      id :us_core_smart_standalone_launch_stu2
      title 'Standalone Launch'
      optional

      group from: :smart_discovery_stu2,
            run_as_group: true
      group from: :smart_standalone_launch_stu2,
            run_as_group: true

      group from: :smart_openid_connect do
        run_as_group
        optional
        config(
          inputs: {
            id_token: { name: :standalone_id_token },
            client_id: { name: :standalone_client_id },
            requested_scopes: { name: :standalone_requested_scopes },
            access_token: { name: :standalone_access_token },
            smart_credentials: { name: :standalone_smart_credentials }
          }
        )
      end

      group from: :smart_token_refresh do
        run_as_group
        optional
        config(
          inputs: {
            refresh_token: { name: :standalone_refresh_token },
            client_id: { name: :standalone_client_id },
            client_secret: { name: :standalone_client_secret },
            received_scopes: { name: :standalone_received_scopes }
          }
        )
      end
    end

    group do
      required_suite_options USCoreOptions::SMART_2_REQUIREMENT
      id :us_core_smart_ehr_launch_stu2
      title 'EHR Launch'
      optional

      group from: :smart_discovery_stu2,
            run_as_group: true
      group from: :smart_ehr_launch_stu2,
            run_as_group: true

      group from: :smart_openid_connect do
        run_as_group
        optional
        config(
          inputs: {
            id_token: { name: :ehr_id_token },
            client_id: { name: :ehr_client_id },
            requested_scopes: { name: :ehr_requested_scopes },
            access_token: { name: :ehr_access_token },
            smart_credentials: { name: :ehr_smart_credentials }
          }
        )
      end

      group from: :smart_token_refresh do
        run_as_group
        optional
        config(
          inputs: {
            refresh_token: { name: :ehr_refresh_token },
            client_id: { name: :ehr_client_id },
            client_secret: { name: :ehr_client_secret },
            received_scopes: { name: :ehr_received_scopes }
          }
        )
      end
    end
  end
end
