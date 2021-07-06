//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Archeron on 05/07/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {

    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    // MARK: - Expression Tests

    func testGivenExpressionIsNotEmpty_WhenResetting_ThenExpressionIsEmpty() {
        calculator.addNumber(3)
        _ = calculator.addMinusOperator()

        calculator.resetExpression()

        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasOnlyTwoElements_WhenComputingExpression_ThenComputingIsNotPossible() {
        calculator.addNumber(3)
        _ = calculator.addPlusOperator()

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

    func testGivenExpressionHasNumbersAndOperatorAndIsNotComputed_WhenAddingOperator_ThenAddingOperatorIsPossible() {
        calculator.addNumber(2)
        _ = calculator.addPlusOperator()
        calculator.addNumber(8)

        let operatorAdded = calculator.addMinusOperator()

        XCTAssertTrue(operatorAdded)
    }

    // MARK: - Adding Numbers Tests

    func testGivenExpressionIsEmpty_WhenAddingANumber_ThenNumberIsAddedToCurrentExpression() {
        calculator.addNumber(3)

        XCTAssertEqual(calculator.currentExpression, "3")
    }

    func testGivenExpressionHasResult_WhenAddingANumber_ThenCurrentExpressionEqualsToNumberAdded() {
        calculator.addNumber(3)
        _ = calculator.addMinusOperator()
        calculator.addNumber(1)
        _ = calculator.computeExpression()

        calculator.addNumber(3)

        XCTAssertEqual(calculator.currentExpression, "3")
    }

    // MARK: - Additions Tests

    func testGivenExpressionHasOneNumber_WhenAddingPlusSign_ThenAddingPlusSignIsPossibleAndExpressionIsTheNumberAndPlusSign() {
        calculator.addNumber(1)

        let result = calculator.addPlusOperator()

        XCTAssertTrue(result)
        XCTAssertEqual(calculator.currentExpression, "1 + ")
    }

    func testGivenExpressionIsEmpty_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addPlusOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(2)
        _ = calculator.addPlusOperator()
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addPlusOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "2 + 2 = 4")
    }

// MARK: - Substractions Tests

    func testGivenExpressionHasOneNumber_WhenAddingMinusSign_ThenAddingMinusSignIsPossibleAndExpressionIsTheNumberAndMinusSign() {
        calculator.addNumber(1)

        let operatorAdded = calculator.addMinusOperator()

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "1 - ")
    }

    func testGivenExpressionIsEmpty_WhenAddingMinusSign_ThenAddingMinusSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addMinusOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingMinusSign_ThenAddingMinusSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(5)
        _ = calculator.addMinusOperator()
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addMinusOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "5 - 2 = 3")
    }

    // MARK: - Multiplications Test

    func testGivenExpressionHasOneNumber_WhenAddingMultiplySign_ThenAddingMultiplySignIsPossibleAndExpressionIsTheNumberAndMultiplySign() {
        calculator.addNumber(1)

        let operatorAdded = calculator.addMultiplyOperator()

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "1 x ")
    }

    func testGivenExpressionIsEmpty_WhenAddingMultiplySign_ThenAddingMultiplySignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addMultiplyOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingMultiplySign_ThenAddingMultiplySignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(5)
        _ = calculator.addMultiplyOperator()
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addMultiplyOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "5 x 2 = 10")
    }

    // MARK: - Divisions Tests

    func testGivenExpressionHasOneNumber_WhenAddingDivideSign_ThenAddingDivideSignIsPossibleAndExpressionIsTheNumberAndDivideSign() {
        calculator.addNumber(1)

        let operatorAdded = calculator.addDivideOperator()

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "1 / ")
    }

    func testGivenExpressionIsEmpty_WhenAddingDivideSign_ThenAddingDivideSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addDivideOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingDivideSign_ThenAddingDivideSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(10)
        _ = calculator.addDivideOperator()
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addDivideOperator()

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "10 / 2 = 5")
    }

    func testGivenExpressionIsADivision_WhenDividingByZero_ThenComputingIsNotPossible() {
        calculator.addNumber(10)
        _ = calculator.addDivideOperator()
        calculator.addNumber(0)

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

}
