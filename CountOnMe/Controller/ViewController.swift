import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Property

    let calculator = Calculator()
    
    // MARK: -  Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNumberButtonsAspect()
        setTextViewAspect()
        setTextViewBehavior()
        // Notification :
        let name = Notification.Name("ExpressionDidChange")
        NotificationCenter.default.addObserver(self, selector: #selector(displayCalculus), name: name, object: nil)
    }
    
    
    // MARK: - Actions

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

    // MARK: - Private

    @objc private func displayCalculus() {
        textView.text = calculator.currentExpression
        // automatic scroll down of the textView :
        let range = NSMakeRange(textView.text.count - 1, 0)
        textView.scrollRangeToVisible(range)
    }

    private func setTextViewBehavior() {
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = true
    }

    private func setTextViewAspect() {
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.darkGray.cgColor
    }

    private func setNumberButtonsAspect() {
        for button in numberButtons {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.darkGray.cgColor
        }
    }

    // MARK: - Alert

    private func incorrectExpressionAlert() {
        let alertVC = UIAlertController(title: "✕", message: "Please enter valid expression", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
