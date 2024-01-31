module USCoreTestKit
  class DataAbsentReasonGroup < Inferno::TestGroup
    id :us_core_311_data_absent_reason
    title 'Missing Data Tests'
    short_description 'Verify that the server is capable of representing missing data.'

    description %(
      The [US Core Missing Data
      Guidance](http://hl7.org/fhir/us/core/STU3.1.1/general-guidance.html#missing-data)
      gives instructions on how to represent various types of missing data.

      In the previous resource tests, each resource returned from the server was
      checked for the presence of missing data. These tests will pass if the
      specified method of representing missing data was observed in the earlier
      tests.
    )
    run_as_group

    test do
      title 'Server represents missing data with the DataAbsentReason Extension'
      id :us_core_311_data_absent_reason_extension
      description %(
        For non-coded data elements, servers SHALL use the DataAbsentReason
        Extension to represent missing data in a required field
      )
      input :dar_extension_found,
            title: 'Data Absent Reason Extension Found',
            locked: true,
            optional: true,
            default: 'false'

      run do
        assert dar_extension_found == 'true',
               'No resources using the DataAbsentReason Extension have been found'
      end
    end

    test do
      title 'Server represents missing data with the DataAbsentReason CodeSystem'
      id :us_core_311_data_absent_reason_code_system
      description %(
        For coded data elements with example, preferred, or extensible binding
        strengths to ValueSets which do not include an appropriate "unknown"
        code, servers SHALL use the "unknown" code from the DataAbsentReason
        CodeSystem.
      )
      input :dar_code_found,
            title: 'Data Absent Reason Extension Found',
            locked: true,
            optional: true,
            default: 'false'

      run do
        assert dar_code_found == 'true',
               'No resources using the DataAbsentReason CodeSystem have been found'
      end
    end
  end
end
