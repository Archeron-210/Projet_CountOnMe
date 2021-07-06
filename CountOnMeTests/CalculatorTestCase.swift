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

    // MARK: - Plus Sign Tests

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

// MARK: - Minus Sign Tests

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


    // Given expression = "1 + 1 = 2", when on appuie sur AC, then expression = ""
}
