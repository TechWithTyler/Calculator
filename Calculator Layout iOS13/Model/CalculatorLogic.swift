//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by TechWithTyler on 11/4/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {

	private var number: Double?

	private var intermediateCalculation: (firstNumber: Double, calcMethod: String)?

	mutating func setNumber(_ number: Double) {
		self.number = number
	}

	mutating func calculate(symbol: String) -> Double? {
		if let n = number {
			switch symbol {
					case "+/-":
				return n * -1
			case "%":
				return n / 100
			case "AC":
				return 0
			case "=":
				return perform2NumberCalculation(secondNumber: n)
				default:
				intermediateCalculation = (firstNumber: n, calcMethod: symbol)
			}
		}
		return nil
	}

	private func perform2NumberCalculation(secondNumber: Double) -> Double? {
		if let firstNumber = intermediateCalculation?.firstNumber, let operation = intermediateCalculation?.calcMethod {
			switch operation {
				case "+":
				return firstNumber + secondNumber
				case "-":
					return firstNumber - secondNumber
				case "×":
					return firstNumber * secondNumber
				case "÷":
					return firstNumber / secondNumber
				default:
					fatalError("Invalid calculation method: \(operation)")
				
			}
		} else {
			return nil
		}
	}

}
