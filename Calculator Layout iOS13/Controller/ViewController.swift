//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var displayLabel: UILabel?

	private var isFinishedTypingNumber: Bool = true

	private var calculator = CalculatorLogic()

	private var displayValue: Double {
		get {
			guard let number = Double((displayLabel?.text)!) else {
				fatalError("Can't convert display text to number!")
			}
			return number
		} set {
			let isInt = floor(newValue) == newValue
			var displayText = (isInt) ? String(format: "%0.0f", newValue) : String(newValue)
			if displayText.count > 14 {
				displayText = "Error"
			}
			displayLabel?.text = displayText
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

	@IBAction func calcButtonPressed(_ sender: UIButton) {
		isFinishedTypingNumber = true
		if let calcMethod = sender.currentTitle {
			if displayLabel?.text == "Error" {
				if calcMethod == "AC" {
					calculator.setNumber(0)
				} else { return }
			} else {
				calculator.setNumber(displayValue)
			}
			if let result = calculator.calculate(symbol: calcMethod) {
				displayValue = result
			}
		}
	}

	@IBAction func numButtonPressed(_ sender: UIButton) {
		if let numValue = sender.currentTitle {
			if isFinishedTypingNumber {
				displayLabel?.text = numValue
				isFinishedTypingNumber = false
			} else {
				guard (displayLabel?.text?.count)! < 14 else { return }
				if numValue == "." {
					let isInt = floor(displayValue) == displayValue
					if !isInt {
						return
					}
				}
				displayLabel?.text = (displayLabel?.text)! + numValue
			}
		}
		if displayLabel?.text == "." {
			displayLabel?.text = "0."
		}
	}


}
