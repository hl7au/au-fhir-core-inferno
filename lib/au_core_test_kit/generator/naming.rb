module USCoreTestKit
  class Generator
    module Naming
      ALLERGY_INTOLERANCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance'
      CARE_PLAN = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan'
      CARE_TEAM = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careteam'
      CONDITION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition'
      IMPLANTABLE_DEVICE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-implantable-device'
      DIAGNOSTIC_REPORT_NOTE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note'
      DIAGNOSTIC_REPORT_LAB = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab'
      DOCUMENT_REFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference'
      ENCOUNTER = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter'
      GOAL = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-goal'
      IMMUNIZATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-immunization'
      LOCATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-location'
      MEDICATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'
      MEDICATION_REQUEST = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationrequest'
      SMOKING_STATUS = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus'
      PEDIATRIC_WEIGHT_FOR_HEIGHT = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-weight-for-height'
      OBSERVATION_LAB = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab'
      PEDIATRIC_BMI_FOR_AGE = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-bmi-for-age'
      PULSE_OXIMETRY = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-pulse-oximetry'
      HEAD_CIRCUMFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/head-occipital-frontal-circumference-percentile'
      ORGANIZATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization'
      PATIENT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'
      PRACTITIONER = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'
      PRACTITIONER_ROLE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'
      PROCEDURE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure'
      PROVENANCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-provenance'

      class << self
        def resources_with_multiple_profiles
          ['Condition', 'DiagnosticReport', 'Observation']
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          if group_metadata.profile_url == HEAD_CIRCUMFERENCE
            return group_metadata.reformatted_version == 'v311' ? 'head_circumference' : 'head_circumference_percentile'
          end

          group_metadata.name
            .delete_prefix('us_core_')
            .gsub('diagnosticreport', 'diagnostic_report')
            .underscore
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end
      end
    end
  end
end
