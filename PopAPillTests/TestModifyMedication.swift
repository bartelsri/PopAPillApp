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

    // test case: modify medication with valid data
    func testModifyMedicationWithValidData(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertTrue(isValid)
        XCTAssertEqual(medication.errorM, "")
    }

    // test case: modify medication with invalid dosage
    func testModifyMedicationWithInvalidDosage(){
        medication.medName = "Test Medication"
        medication.dosage = "-1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid dosage")
    }
    // test case: modify medication with empty dosage
     func testModifyMedicationWithInvalidDosage(){
         medication.medName = "Test Medication"
         medication.dosage = ""
         medication.unit = "Pill"
         medication.frequency = "2"

         let isValid = medication.validate()
         XCTAssertFalse(isValid)
         XCTAssertEqual(medication.errorM, "Fill in all fields")
     }

    // test case: modify medication with invalid unit
    func testModifyMedicationWithInvalidUnit(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "3"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid unit")
    }

    // test case: modify medication with empty unit
    func testModifyMedicationWithInvalidUnit(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = ""
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Fill in all fields")
    }

    // test case: modify medication with invalid frequency
    func testModifyMedicationWithInvalidFrequency(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "abc"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid frequency")
    }
    // test case: modify medication with empty frequency
    func testModifyMedicationWithInvalidFrequency(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = ""

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Fill in all fields")
    }

    // test case: add new medication with valid data
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertTrue(isValid)
        XCTAssertEqual(newMedication.errorM, "")
    }

    // test case: add new medication with empty medName
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "", dosage: "1", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Fill in all fields")
    }

    // test case: add new medication with invalid dosage
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "-1", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Invalid dosage")
    }

    // test case: add new medication with empty dosage
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Fill in all fields")
    }

    // test case: add new medication with invalid unit
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "3", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Invalid unit")
    }
    // test case: add new medication with empty unit
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Fill in all fields")
    }

    // test case: add new medication with invalid frequency
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "Pill", frequency: "abc")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Invalid frequency")
    }

    // test case: add new medication with empty frequency
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "Pill", frequency: "")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Fill in all fields")
    }

}