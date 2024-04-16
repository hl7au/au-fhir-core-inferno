module AUCoreTestKit
  class Generator
    module Naming
      HEART_RATE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate'
      PATIENT = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient'
      BLOOD_PRESSURE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure'
      PROVENANCE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance'
      LOCATION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-location'
      BODY_TEMPERATURE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp'
      RESPIRATION_RATE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate'
      MEDICATION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication'
      SEX_ASSIGNED_AT_BIRTH = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-rsg-sexassignedab'
      MEDICATIONSTATEMENT = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement'
      ALLERGYINTOLERANCE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance'
      PATHOLOGY_RESULT_OBSERVATION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path'
      BODY_HEIGHT = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight'
      MEDICATIONREQUEST = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest'
      SMOKING_STATUS = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus'
      CONDITION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition'
      WAIST_CIRCUMFERENCE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum'
      BODY_WEIGHT = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight'
      ENCOUNTER = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter'
      ORGANIZATION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization'
      PRACTITIONER = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner'
      PROCEDURE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure'
      IMMUNIZATION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization'
      DIAGNOSTIC_RESULT_OBSERVATION = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult'
      PRACTITIONERROLE = 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole'

      class << self
        def resources_with_multiple_profiles
          %w[Condition DiagnosticReport Observation]
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

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
