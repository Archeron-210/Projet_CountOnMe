//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let calculator = Calculator()

    //MARK:- Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    //MARK:- View Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = true
        // Notification :
        let name = Notification.Name("ExpressionDidChange")
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalculus), name: name, object: nil)
    }
    
    
    //MARK:- Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(sender.tag)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "+")

        if !success {
            incorrectExpressionAlert()
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "-")

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "x")

        if !success {
            incorrectExpressionAlert()
        }
    }


    @IBAction func tappedDivideButton(_ sender: UIButton) {
        let success = calculator.addOperator(operand: "/")

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedPointButton(_ sender: UIButton) {
        let success = calculator.addPoint()

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let success = calculator.computeExpression()

        if !success {
            incorrectExpressionAlert()
        }
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        calculator.resetExpression()
    }

    //MARK:- Private Functions

    @objc private func displayCalculus() {
        textView.text = calculator.currentExpression
        let range = NSMakeRange(textView.text.count - 1, 0)
        textView.scrollRangeToVisible(range)
    }

    private func incorrectExpressionAlert() {
        let alertVC = UIAlertController(title: "Erreur !", message: "Entrez une expression correcte", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
