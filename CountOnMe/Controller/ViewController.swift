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

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.isSelectable = false
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(sender.tag)
        // A retirer quand on ajoute la notif
        textView.text = calculator.currentExpression
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        let success = calculator.addPlusOperator()

        if !success {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        // A retirer quand on ajoute la notif
        textView.text = calculator.currentExpression
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        let success = calculator.addMinusOperator()

        if !success {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        // A retirer quand on ajoute la notif
        textView.text = calculator.currentExpression
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let success = calculator.computeExpression()

        if success {
            textView.text = calculator.currentExpression
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
    }
}
