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

    // MARK: - Expression & Computing Tests

    func testGivenExpressionIsNotEmpty_WhenResetting_ThenExpressionIsEmpty() {
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "-")

        calculator.resetExpression()

        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasANumber_WhenAddingWrongOperator_ThenItIsNotPossible() {
        calculator.addNumber(5)

        let operatorAdded = calculator.addOperator(operand: "y")

        XCTAssertFalse(operatorAdded)
    }

    func testGivenExpressionHasANumber_WhenAddingAPointToMakeItDecimal_ThenItIsPossibleAdExpressionIsNumberAndPoint() {
        calculator.addNumber(2)

        let pointAdded = calculator.addPoint()

        XCTAssertTrue(pointAdded)
        XCTAssertEqual(calculator.currentExpression, "2.")
    }

    func testGivenExpressionIsEmpty_WhenAddingAPoint_ThenItIsNotPossible() {
        let pointAdded = calculator.addPoint()

        XCTAssertFalse(pointAdded)
    }

    func testGivenExpressionHasANumberAndAPoint_WhenAddingOperator_ThenItIsNotPossible() {
        calculator.addNumber(2)
        _ = calculator.addPoint()

        let operatorAdded = calculator.addOperator(operand: "+")

        XCTAssertFalse(operatorAdded)
    }

    func testGivenExpressionHasANumberAndAPoint_WhenComputing_ThenItIsNotPossible() {
        calculator.addNumber(2)
        _ = calculator.addPoint()

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

    func testGivenExpressionHasOnlyTwoElements_WhenComputingExpression_ThenComputingIsNotPossible() {
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "+")

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

    func testGivenExpressionHasNumbersAndOperatorAndIsNotComputed_WhenAddingOperator_ThenAddingOperatorIsPossible() {
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(8)

        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertTrue(operatorAdded)
    }

    func testGivenExpressionHasAlreadyAResult_WhenComputing_ThenComputingIsPossibleAndResultIsTheSame() {
        calculator.addNumber(5)
        _ = calculator.addOperator(operand: "x")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let result = calculator.computeExpression()

        XCTAssertTrue(result)
        XCTAssertEqual(calculator.currentExpression, "5 x 2 = 10.0")
    }

    func testGivenExpressionEndsWithAnOperator_WhenComputing_ThenComputingIsNotPossible() {
        calculator.addNumber(7)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "+")

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

    // MARK: - Adding Numbers Tests

    func testGivenExpressionIsEmpty_WhenAddingANumber_ThenNumberIsAddedToCurrentExpression() {
        calculator.addNumber(3)

        XCTAssertEqual(calculator.currentExpression, "3")
    }

    func testGivenExpressionHasResult_WhenAddingANumber_ThenCurrentExpressionEqualsToNumberAdded() {
        calculator.addNumber(3)
        _ = calculator.addOperator(operand: "-")
        calculator.addNumber(1)
        _ = calculator.computeExpression()

        calculator.addNumber(3)

        XCTAssertEqual(calculator.currentExpression, "3")
    }

    // MARK: - Additions Tests

    func testGivenExpressionHasOneNumber_WhenAddingPlusSign_ThenAddingPlusSignIsPossibleAndExpressionIsTheNumberAndPlusSign() {
        calculator.addNumber(1)

        let result = calculator.addOperator(operand: "+")

        XCTAssertTrue(result)
        XCTAssertEqual(calculator.currentExpression, "1 + ")
    }

    func testGivenExpressionIsEmpty_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addOperator(operand: "+")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addOperator(operand: "+")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "2 + 2 = 4.0")
    }

    // MARK: - Substractions Tests

    func testGivenExpressionHasOneNumber_WhenAddingMinusSign_ThenAddingMinusSignIsPossibleAndExpressionIsTheNumberAndMinusSign() {
        calculator.addNumber(1)

        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "1 - ")
    }

    func testGivenExpressionIsEmpty_WhenAddingMinusSign_ThenAddingMinusSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingMinusSign_ThenAddingMinusSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(5)
        _ = calculator.addOperator(operand: "-")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addOperator(operand: "-")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "5 - 2 = 3.0")
    }

    // MARK: - Multiplications Test

    func testGivenExpressionHasOneNumber_WhenAddingMultiplySign_ThenAddingMultiplySignIsPossibleAndExpressionIsTheNumberAndMultiplySign() {
        calculator.addNumber(1)

        let operatorAdded = calculator.addOperator(operand: "x")

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "1 x ")
    }

    func testGivenExpressionIsEmpty_WhenAddingMultiplySign_ThenAddingMultiplySignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addOperator(operand: "x")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingMultiplySign_ThenAddingMultiplySignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(5)
        _ = calculator.addOperator(operand: "x")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addOperator(operand: "x")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "5 x 2 = 10.0")
    }

    // MARK: - Divisions Tests

    func testGivenExpressionHasOneNumber_WhenAddingDivideSign_ThenAddingDivideSignIsPossibleAndExpressionIsTheNumberAndDivideSign() {
        calculator.addNumber(1)

        let operatorAdded = calculator.addOperator(operand: "/")

        XCTAssertTrue(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "1 / ")
    }

    func testGivenExpressionIsEmpty_WhenAddingDivideSign_ThenAddingDivideSignIsNotPossibleAndExpressionIsEmpty() {
        let operatorAdded = calculator.addOperator(operand: "/")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    func testGivenExpressionHasAResult_WhenAddingDivideSign_ThenAddingDivideSignIsNotPossibleAndExpressionIsTheSame() {
        calculator.addNumber(10)
        _ = calculator.addOperator(operand: "/")
        calculator.addNumber(2)
        _ = calculator.computeExpression()

        let operatorAdded = calculator.addOperator(operand: "/")

        XCTAssertFalse(operatorAdded)
        XCTAssertEqual(calculator.currentExpression, "10 / 2 = 5.0")
    }

    func testGivenExpressionIsADivision_WhenDividingByZero_ThenComputingIsNotPossible() {
        calculator.addNumber(10)
        _ = calculator.addOperator(operand: "/")
        calculator.addNumber(0)

        let result = calculator.computeExpression()

        XCTAssertFalse(result)
    }

    // MARK: - Priorities

    func testGivenExpressionHasAllTypesOfOperators_WhenComputing_ThenResultIsCorrectWithOperationPriorities() {
        calculator.addNumber(10)
        _ = calculator.addOperator(operand: "/")
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "+")
        calculator.addNumber(5)
        _ = calculator.addOperator(operand: "x")
        calculator.addNumber(2)
        _ = calculator.addOperator(operand: "-")
        calculator.addNumber(2)

        _ = calculator.computeExpression()

        XCTAssertEqual(calculator.currentExpression, "10 / 2 + 5 x 2 - 2 = 13.0")
        XCTAssertNotEqual(calculator.currentExpression, "10 / 2 + 5 x 2 - 2 = 18.0")

    }

}
