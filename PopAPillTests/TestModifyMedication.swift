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

    //test case: modify medication with empty medication name
    func testModifyMedicationWithEmptyMedName(){
        medication.medName = ""
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Please fill in all fields")
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
     func testModifyMedicationWithEmptyDosage(){
         medication.medName = "Test Medication"
         medication.dosage = ""
         medication.unit = "Pill"
         medication.frequency = "2"

         let isValid = medication.validate()
         XCTAssertFalse(isValid)
         XCTAssertEqual(medication.errorM, "Please fill in all fields")
     }

    // test case: modify medication with invalid unit
    func testModifyMedicationWithInvalidUnit(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "-1"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Invalid unit")
    }

    // test case: modify medication with empty unit
    func testModifyMedicationWithEmptyUnit(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = ""
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Please fill in all fields")
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
    func testModifyMedicationWithEmptyFrequency(){
        medication.medName = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = ""

        let isValid = medication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(medication.errorM, "Please fill in all fields")
    }

    // test case: add new medication with valid data
    func testAddNewMedicationWithValidData(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertTrue(isValid)
        XCTAssertEqual(newMedication.errorM, "")
    }

    // test case: add new medication with empty medName
    func testAddNewMedicationWithEmptyMedName(){
        let newMedication = Medication(medName: "", dosage: "1", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Please fill in all fields")
    }

    // test case: add new medication with invalid dosage
    func testAddNewMedicationWithInvalidDosage(){
        let newMedication = Medication(medName: "New Medication", dosage: "-1", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Invalid dosage")
    }

    // test case: add new medication with empty dosage
    func testAddNewMedicationWithEmptyDosage(){
        let newMedication = Medication(medName: "New Medication", dosage: "", unit: "Pill", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Please fill in all fields")
    }

    // test case: add new medication with invalid unit
    func testAddNewMedicationWithInvalidUnit(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "-1", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Invalid unit")
    }
    // test case: add new medication with empty unit
    func testAddNewMedicationWithEmptyUnit(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "", frequency: "2")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Please fill in all fields")
    }

    // test case: add new medication with invalid frequency
    func testAddNewMedicationWithInvalidFrequency(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "Pill", frequency: "abc")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Invalid frequency")
    }

    // test case: add new medication with empty frequency
    func testAddNewMedicationWithEmptyFrequency(){
        let newMedication = Medication(medName: "New Medication", dosage: "1", unit: "Pill", frequency: "")

        let isValid = newMedication.validate()
        XCTAssertFalse(isValid)
        XCTAssertEqual(newMedication.errorM, "Please fill in all fields")
    }

}