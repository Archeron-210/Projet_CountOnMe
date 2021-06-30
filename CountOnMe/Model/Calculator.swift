//
//  Calculator.swift
//  CountOnMe
//
//  Created by Archeron on 30/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
class Calculator {
    private var elements: [String] = []

    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    func add() {
        guard expressionIsCorrect else {
            return
        }
        elements.append(" + ")
    }
}
