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
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true
        // Notification :
        let name = Notification.Name("ExpressionDidChange")
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalculus), name: name, object: nil)
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(sender.tag)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        let success = calculator.addPlusOperator()

        if !success {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        let success = calculator.addMinusOperator()

        if !success {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let success = calculator.computeExpression()

        if !success {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
    }

    @objc func displayCalculus() {
        textView.text = calculator.currentExpression
    }
}
