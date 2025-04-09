//
// TestModifyMedication.swift
// PopAPillTests
//
// created by bartelsri on 3/25/25

import XCTest
@testable import PopAPill

class TestModifyMedication : XCTestCase {

    var medication: ModifyMedicationViewModel!

    override func setUp(){
        super.setUp()
        medication = ModifyMedicationViewModel()
    }

    override func tearDown(){
        medication = nil
        super.tearDown()
    }

    // test case: modify or add medication with valid data
    func testModifyOrAddMedicationWithValidData(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertTrue(isValid)
        XCTAssertEqual(medication.errorM, "")
    }

    //test case:  modify or add medication with empty medication name
    func testModifyOrAddMedicationWithEmptyMedName(){
        medication.medName = ""
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Please fill in all fields")
    }

    // test case: modify or add medication with invalid dosage
    func testModifyOrAddMedicationWithInvalidDosage(){
        medication.medName = "Test Medication"
        medication.dosage = "-1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid dosage")
    }
    // test case: modify or add medication with empty dosage
     func testModifyOrAddMedicationWithEmptyDosage(){
         medication.medName = "Test Medication"
         medication.dosage = ""
         medication.unit = "Pill"
         medication.frequency = "2"

         let isValid = medication.validate()
         XCTAssertFalse(isValid)
         XCTAssertEqual(medication.errorM, "Please fill in all fields")
     }

    // test case: modify or add medication with invalid unit
    func testModifyOrAddMedicationWithInvalidUnit(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "-1"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid unit")
    }

    // test case: modify or add medication with empty unit
    func testModifyOrAddMedicationWithEmptyUnit(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = ""
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Please fill in all fields")
    }

    // test case: modify or add medication with invalid frequency
    func testModifyOrAddMedicationWithInvalidFrequency(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "abc"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid frequency")
    }
    // test case: modify or add medication with empty frequency
    func testModifyOrAddMedicationWithEmptyFrequency(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = ""

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Please fill in all fields")
    }
}

