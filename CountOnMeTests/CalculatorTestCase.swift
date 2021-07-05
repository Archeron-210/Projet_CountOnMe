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


    // Given expression = "1", when on appuie sur plus, then expression = "1 + " et plus renvoie true
    // Given expression = "", when on appuie sur plus, then expression = "" et plus renvoie false
    // Given expression = "1 + 1 = 2", when on appuie sur plus, then expression =  "1 + 1 = 2" et plus renvoie false


    // Pareil pour moins

    // Given expression = "1 + 1 = 2", when on appuie sur AC, then expression = ""
}
