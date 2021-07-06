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
    func testGivenExpressionHasOneNumber_WhenAddingPlusSign_ThenAddingPlusSignIsPossibleAndExpressionIsTheNumberAndPlusSign() {
        calculator.addNumber(1)

        let result = calculator.addPlusOperator()

        XCTAssertTrue(result)
        XCTAssertEqual(calculator.currentExpression, "1 + ")

    }

    func testGivenExpressionIsEmpty_WhenAddingPlusSign_ThenAddingPlusSignIsNotPossibleAndExpressionIsEmpty() {
        let result = calculator.addPlusOperator()

        XCTAssertFalse(result)
        XCTAssertEqual(calculator.currentExpression, "")
    }

    // Given expression = "1 + 1 = 2", when on appuie sur plus, then expression =  "1 + 1 = 2" et plus renvoie false


    // Pareil pour moins

    // Given expression = "1 + 1 = 2", when on appuie sur AC, then expression = ""
}
