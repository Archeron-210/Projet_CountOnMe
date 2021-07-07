//
//  Calculator.swift
//  CountOnMe
//
//  Created by Archeron on 30/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

    // MARK: - Private variables

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

    // MARK: - Functions

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

        guard let reducedPriority = reducePriorityOperations(elements: elements) else {
            return false
        }

        guard let reducedBasic = reduceBasicOperations(reducedPriority) else {
            return false
        }

        guard let result = reducedBasic.first else {
            return false
        }

        currentExpression.append(" = \(result)")

        return true
    }

    private func reduceBasicOperations(_ elements: [String]) -> [String]? {
        // Create local copy of operations :
        var localElements = elements

        // Iterate over operations while an operand still here :
        while localElements.count > 1 {
            guard let left = Double(localElements[0]) else {
                return nil
            }

            let operand = localElements[1]

            guard let right = Double(localElements[2]) else {
                return nil
            }

            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return nil
            }

            // rounded result to avoid displaying too many numbers :
            let resultToDisplay = (result * 100).rounded() / 100

            localElements = Array(localElements.dropFirst(3))
            localElements.insert("\(resultToDisplay)", at: 0)
        }

        return localElements
    }

    func reducePriorityOperations(elements: [String]) -> [String]? {
        var localElements = elements
        while localElements.contains("x") || localElements.contains("/") {
            guard let index = localElements.firstIndex(where: { $0 == "x" || $0 == "/" }) else {
                return nil
            }
            guard let left = Double(localElements[index-1]) else {
                return nil
            }
            guard let right = Double(localElements[index+1]) else {
                return nil
            }
            let operand = localElements[index]
            // Division by 0 :
            if operand == "/" && right == 0 {
                return nil
            }
            let result: Double
            switch operand {
                case "x": result = left * right
                case "/": result = left / right
                default : return nil
            }
            for _ in 1...3 {
                // Remove the 3 elements at the lowest index
                localElements.remove(at: index-1)
            }
            // Insert result of reduced operation at the lowest index
            localElements.insert("\(result)", at: index-1)
        }
        return localElements
    }

    func sendCurrentExpressionDidChangeNotification() {
        let name = Notification.Name(rawValue: "ExpressionDidChange")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)

    }
}
