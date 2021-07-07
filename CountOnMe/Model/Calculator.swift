//
//  Calculator.swift
//  CountOnMe
//
//  Created by Archeron on 30/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    private(set) var currentExpression: String = "" {
        didSet {
            sendCurrentExpressionDidChangeNotification()
        }
    }

    private var elements: [String] {
        return currentExpression.split(separator: " ").map { "\($0)" }
    }

    private var expressionHaveResult: Bool {
        return elements.contains("=")
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var expressionHaveAtLeastOneNumber: Bool {
        return elements.count >= 1 && Int(elements.first ?? "") != nil
    }

    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }

    func addNumber(_ number: Int) {
        if expressionHaveResult {
            currentExpression = ""
        }
        currentExpression.append("\(number)")
    }

    func resetExpression() {
        currentExpression = ""
    }

    func addPlusOperator() -> Bool {
        guard expressionIsCorrect, !expressionHaveResult, expressionHaveAtLeastOneNumber else {
            return false
        }
        currentExpression.append(" + ")
        return true
    }

    func addMinusOperator() -> Bool {
        guard expressionIsCorrect, !expressionHaveResult, expressionHaveAtLeastOneNumber else {
            return false
        }
        currentExpression.append(" - ")
        return true
    }

    func addMultiplyOperator() -> Bool {
        guard expressionIsCorrect, !expressionHaveResult, expressionHaveAtLeastOneNumber else {
            return false
        }
        currentExpression.append(" x ")
        return true
    }

    func addDivideOperator() -> Bool {
        guard expressionIsCorrect, !expressionHaveResult, expressionHaveAtLeastOneNumber else {
            return false
        }
        currentExpression.append(" / ")
        return true
    }

    func computeExpression() -> Bool {
        guard !expressionHaveResult else {
            // result is already calculated
            return true
        }

        guard expressionHaveEnoughElement else {
            return false
        }

        guard expressionIsCorrect else {
            return false
        }

        // Create local copy of operations
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else {
                return false
            }

            let operand = operationsToReduce[1]

            guard let right = Double(operationsToReduce[2]) else {
                return false
            }

            if operand.elementsEqual("/") && right == 0 {
                return false
            }

            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
            default: return false
            }

            // rounded result to avoid displaying too many numbers :
            let resultToDisplay = (result * 100).rounded() / 100

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(resultToDisplay)", at: 0)
        }

        guard let result = operationsToReduce.first else {
            return false
        }

        currentExpression.append(" = \(result)")

        return true
    }

    func sendCurrentExpressionDidChangeNotification() {
        let name = Notification.Name(rawValue: "ExpressionDidChange")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)

    }
}
