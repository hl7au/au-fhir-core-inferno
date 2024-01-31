require_relative '../../lib/us_core_test_kit/fhir_resource_navigation'

RSpec.describe USCoreTestKit::FHIRResourceNavigation do
  # Using a must_support_test instance to perform navigation in order to have access to metadata.
  let (:must_support_coverage_test) {
    USCoreTestKit::USCoreV610::CoverageMustSupportTest.new
  }
  let (:must_support_heartrate_test) {
    USCoreTestKit::USCoreV610::HeartRateMustSupportTest.new
  }
  let (:coverage_with_two_classes) {
    FHIR::Coverage.new.tap{ |cov|
      cov.local_class = [FHIR::Coverage::Class.new.tap{ |loc_class|
        loc_class.type = FHIR::CodeableConcept.new.tap{ |code_concept|
          code_concept.coding = [FHIR::Coding.new.tap{ |coding|
            coding.system = "http://terminology.hl7.org/CodeSystem/coverage-class"
            coding.code = "group"
          }]
        }
        loc_class.value = "groupclass"
        },
        FHIR::Coverage::Class.new.tap{ |loc_class|
          loc_class.type = FHIR::CodeableConcept.new.tap{ |code_concept|
            code_concept.coding = [FHIR::Coding.new.tap{ |coding|
              coding.system = "http://terminology.hl7.org/CodeSystem/coverage-class"
              coding.code = "plan"
            }]
          }
        loc_class.value = "planclass"
        }
        ]
        cov.identifier = [FHIR::Identifier.new.tap {|identifier|
          identifier.type = FHIR::CodeableConcept.new.tap { |code_concept|
            code_concept.coding = [FHIR::Coding.new.tap{ |coding|
              coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
              coding.code = "MB"
            }]
          }
          identifier.system = "https://github.com/inferno-framework/us-core-test-kit"
          identifier.value = "f4a375d2-4e53-4f81-ba95-345e7573b550"
        }
      ]
    }
  }
  let (:heartrate_by_value) {
    FHIR::Observation.new.tap { |observation| 
      observation.category = [FHIR::CodeableConcept.new.tap { |code_concept| 
        code_concept.coding = [FHIR::Coding.new.tap { |code| 
          code.system = 'something-else'
          code.code = 'vital-signs'
        }]
        code_concept.text = 'heartrate-example-wrong-system'
      },
      FHIR::CodeableConcept.new.tap { |code_concept| 
        code_concept.coding = [FHIR::Coding.new.tap { |code| 
          code.system = 'http://terminology.hl7.org/CodeSystem/observation-category'
          code.code = 'something-else'
        }]
        code_concept.text = 'heartrate-example-wrong-code'
      },
        FHIR::CodeableConcept.new.tap { |code_concept| 
        code_concept.coding = [FHIR::Coding.new.tap { |code| 
          code.system = 'http://terminology.hl7.org/CodeSystem/observation-category'
          code.code = 'vital-signs'
        }]
        code_concept.text = 'heartrate-example'
      }]
      observation.valueQuantity = FHIR::Quantity.new.tap { |quantity| 
        quantity.value = 44
        quantity.unit = "beats/min"
        quantity.system = "http://unitsofmeasure.org"
        quantity.code = "/min"
      }
    }
  }

  context '#find_a_value_at' do
    it 'finds the first value when not given a specific slice' do
      expect(must_support_coverage_test.find_a_value_at(coverage_with_two_classes, 'class.value')).to  eq('groupclass')
    end

    it 'finds a specific slice value when given a specific slice' do
      expect(must_support_coverage_test.find_a_value_at(coverage_with_two_classes, 'class:plan.value')).to eq('planclass')
    end

    it 'can find fixed elements given a specific slice' do
      expect(must_support_coverage_test.find_a_value_at(coverage_with_two_classes, 'identifier:memberid.type.coding.code')).to eq('MB')
    end

    it 'can find an element in a specific slice discriminated by values' do
      expect(must_support_heartrate_test.find_a_value_at(heartrate_by_value, 'category:VSCat.text')).to eq('heartrate-example')
    end

    it 'can find an element in a specific slice discriminated by type' do
      expect(must_support_heartrate_test.find_a_value_at(heartrate_by_value, 'value[x]:valueQuantity.code')).to eq('/min')
    end
  end
end
