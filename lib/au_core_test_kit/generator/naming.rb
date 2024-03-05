module AUCoreTestKit
  class Generator
    module Naming
      ALLERGY_INTOLERANCE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-allergyintolerance'
      CARE_PLAN = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-careplan'
      CARE_TEAM = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-careteam'
      CONDITION = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-condition'
      IMPLANTABLE_DEVICE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-implantable-device'
      DIAGNOSTIC_REPORT_NOTE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-diagnosticreport-note'
      DIAGNOSTIC_REPORT_LAB = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-diagnosticreport-lab'
      DOCUMENT_REFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-documentreference'
      ENCOUNTER = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-encounter'
      GOAL = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-goal'
      IMMUNIZATION = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-immunization'
      LOCATION = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-location'
      MEDICATION = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-medication'
      MEDICATION_REQUEST = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-medicationrequest'
      SMOKING_STATUS = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-smokingstatus'
      PEDIATRIC_WEIGHT_FOR_HEIGHT = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-weight-for-height'
      OBSERVATION_LAB = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-observation-lab'
      PEDIATRIC_BMI_FOR_AGE = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-bmi-for-age'
      PULSE_OXIMETRY = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-pulse-oximetry'
      HEAD_CIRCUMFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/head-occipital-frontal-circumference-percentile'
      ORGANIZATION = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-organization'
      PATIENT = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-patient'
      PRACTITIONER = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-practitioner'
      PRACTITIONER_ROLE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-practitionerrole'
      PROCEDURE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-procedure'
      PROVENANCE = 'http://hl7.org/fhir/us/core/StructureDefinition/au-core-provenance'

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
            .delete_prefix('au_core_')
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
