//
// TestModifyMedication.swift
// PopAPillTests
//
// created by bartelsri on 3/25/25


import XCTest
@testable import PopAPill

class TestModifyMedication : XCTestCase {

    var medication : ModifyMedication!

    override fun setUp(){
        super.setUp()
        medication = ModifyMedication()
    }

    override fun tearDown(){
        medication = nil
        super.tearDown()
    }

    // test case: modify medication with valid data
    func testModifyMedicationWithValidData(){
        medication.name = "Test Medication"
        medication.dosage = "1"
        medication.unit = "Pill"
        medication.frequency = "2"

        let isValid = medication.validate()
        XCTAssertTrue(isValid)
        XCTAssertEqual(medication.errorM, "")
    }

    // test case: modify medication with invalid dosage
    func testModifyMedicationWithInvalidData(){

    }
    // test case: modify medication with invalid frequency
    // test case: modify medication with empty data
    // test case: add new medication with valid data
    // test case: add new medication with invalid dosage
    // test case: add new medication with invalid frequency
    // test case: add new medication with empty data

}