//
//  ButtonPadHorz.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/30/23.
//

import SwiftUI
import Darwin
let e = Darwin.M_E
let pi = Double.pi
import Foundation

struct ButtonPadHorz: View {
    @State private var currentNumber: String = "0"
    @State private var displayNumber: String = "0"
    @State private var storedNumber: Double = 0
    @State private var operation: Operation = .none
    @State private var isDoingOp = false
    @State private var angle = "DEG"
    
    let buttons = [
        ["(", ")", "mc", "m+", "m-", "mr", "AC", "+/_", "%", "÷"],
        ["2nd", "x^2", "x^3", "x^y", "e^x", "10^x", "7", "8", "9", "×"],
        ["1/x", "sqrt", "cubrt", "yrt", "ln", "log10","4", "5", "6", "-"],
        ["x!", "sin", "cos", "tan", "e", "EE","1", "2", "3", "+"],
        ["Rad", "sinh", "cosh", "tanh", "pi", "Rand","0", ".", "="]
    ]
    
    var body: some View {
        
        VStack(spacing: 14) {
            Spacer()
            
            Text(displayNumber)
                .font(.system(size: 150))
                .foregroundColor(.white)
                .padding(.trailing, 100)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 1366, alignment: .trailing)
                .truncationMode(.tail)
            
            VStack(spacing: 12) {
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.buttonTapped(button)
                            }) {
                                Text(button)
                                    .font(.system(size: 32))
                                    .frame(width: buttonWidth(button), height: buttonHeight())
                                    .background(buttonColor(button))
                                    .foregroundColor(buttonTextColor(button))
                                    .cornerRadius(buttonWidth(button) / 2)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .background(Color.black)
    }
    
    private func buttonTapped(_ button: String) {

        switch button {
        case "AC":
            clearAll()
        case "+/_":
            negateNum()
        case "%":
            percentNum()
        case "+":
            performOperation(.add)
        case "-":
            performOperation(.subtract)
        case "×":
            performOperation(.multiply)
        case "÷":
            performOperation(.divide)
        case "=":
            performEquals()
        case "mc":
            storedNumber = 0
        case "m+":
            performOperation(.subtract)
        case "m-":
            performOperation(.subtract)
        case "mr":
            currentNumber = String(storedNumber)
            displayNumber = currentNumber
            displayNumber = shortenString(s: displayNumber)
        case "x^2":
            powerOf(x: Double(currentNumber)!, y: 2)
        case "x^3":
            powerOf(x: Double(currentNumber)!, y: 3)
        case "x^y":
            powerOf(x: storedNumber, y: Double(currentNumber)!)
        case "e^x":
            powerOf(x: e, y: Double(currentNumber)!)
        case "10^x":
            powerOf(x: 10, y: Double(currentNumber)!)
        case "1/x":
            currentNumber = String(1/Double(currentNumber)!)
            displayNumber = currentNumber
            displayNumber = shortenString(s: displayNumber)
        case "sqrt":
            powerOf(x: Double(currentNumber)!, y: 1/2)
        case "cubrt":
            powerOf(x: Double(currentNumber)!, y: 1/3)
        case "yrt":
            powerOf(x: Double(currentNumber)!, y: 1/storedNumber)
        case "ln":
            logfn(x: e, y: Double(currentNumber)!)
        case "log10":
            logfn(x: Double(currentNumber)!, y: 10)
        case "x!":
            fact(x: Int(currentNumber)!)
        case "sin":
            performTrig(x: Double(currentNumber)!, y: "sin")
        case "cos":
            performTrig(x: Double(currentNumber)!, y: "cos")
        case "tan":
            performTrig(x: Double(currentNumber)!, y: "tan")
        case "e":
            currentNumber = String(e)
            displayNumber = currentNumber
            displayNumber = shortenString(s: displayNumber)
        /* case "EE":
            currentNumber = String(e)
            displayNumber = currentNumber */
        case "Rad":
            if(self.angle == "RAD") {
                self.angle = "DEG"
            }
            else {
                self.angle = "RAD"
            }
        case "sinh":
            performTrig(x: Double(currentNumber)!, y: "sinh")
        case "cosh":
            performTrig(x: Double(currentNumber)!, y: "cosh")
        case "tanh":
            performTrig(x: Double(currentNumber)!, y: "tanh")
        case "pi":
            currentNumber = String(pi)
            displayNumber = currentNumber
            displayNumber = shortenString(s: displayNumber)
        case "Rand":
            currentNumber = String(Double(arc4random()))
            displayNumber = currentNumber
            displayNumber = shortenString(s: displayNumber)
        default:
            if let number = Int(button) {
                appendNumber(number)
            } else if button == "." {
                appendDecimal()
            }
        }
    }
    private func shortenString(s : String) -> String {
        let trimToCharacter = 14
        let trimToCharacter2 = 10
        var d = Double(s)!
        var count = 0
        var shortString = ""
        if(d > 1000000) {
            while(d >= 10){
                d /= 10.0
                count+=1
            }
            shortString = String(d).prefix(trimToCharacter2) + "e+" + String(count)
        }
        else {
            shortString = String(s.prefix(trimToCharacter))
        }
        return shortString
    }
    private func appendNumber(_ number: Int) {
        if currentNumber == "0" {
            currentNumber = String(number)
        } else {
            currentNumber.append(String(number))
        }
        displayNumber = currentNumber
    }
    
    private func appendDecimal() {
        if currentNumber.contains(".") {
            return
        }
        
        currentNumber.append(".")
        displayNumber = currentNumber
    }
    
    private func performOperation(_ operation: Operation) {
        self.operation = operation
        if currentNumber == "0" {
            return
        } else {
            if isDoingOp {
                let current = Double(currentNumber)!
                
                switch operation {
                    case .add:
                        currentNumber = String(storedNumber + current)
                    case .subtract:
                        currentNumber = String(storedNumber - current)
                    case .multiply:
                        currentNumber = String(storedNumber * current)
                    case .divide:
                        currentNumber = String(storedNumber / current)
                    default:
                        break
                }
            }
        }
        displayNumber = currentNumber
        storedNumber = Double(currentNumber)!
        currentNumber = "0"
        self.isDoingOp = true
    }
    private func powerOf(x: Double, y: Double) {
        currentNumber = String(pow(x, y))
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
    }
    private func logfn(x: Double, y: Double){
        let current = log(x)/log(y)
        currentNumber = String(current)
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
    }
    private func fact(x: Int){
        var count = x
        var current = 1
        if (x != 0) {
            while(count > 0) {
                current *= count
                count -= 1
            }
        }
        currentNumber = String(current)
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
    }
    private func performTrig(x: Double, y: String) {
        var current = 0.0
        switch y {
            case "sin" :
                current = sin(x)
            case "cos" :
                current = cos(x)
            case "tan" :
                current = tan(x)
            case "sinh" :
                current = sinh(x)
            case "cosh" :
                current = cosh(x)
            case "tanh" :
                current = tanh(x)
            default:
                current = 0.0
        }
        currentNumber = String(current)
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
    }
    private func clearAll() {
        self.currentNumber = "0"
        self.displayNumber = "0"
        self.storedNumber = 0
        self.operation = .none
        self.isDoingOp = false
    }
    private func negateNum() {
        if let num = Double(currentNumber) {
            self.currentNumber = String(num * -1.0)
            self.displayNumber = self.currentNumber
        }
    }
    private func percentNum() {
        if let num = Double(currentNumber) {
            self.currentNumber = String(num / 100)
            self.displayNumber = self.currentNumber
        }
    }
    
    private func performEquals() {
        if currentNumber == "0" {
            return
        }
        
        let current = Double(currentNumber)!
        
        switch operation {
        case .add:
            currentNumber = String(storedNumber + current)
        case .subtract:
            currentNumber = String(storedNumber - current)
        case .multiply:
            currentNumber = String(storedNumber * current)
        case .divide:
            currentNumber = String(storedNumber / current)
        default:
            break
        }
        isDoingOp = false
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
    }
    
    private func buttonWidth(_ button: String) -> CGFloat {
        let num = 120.0//((UIScreen.main.bounds.width - 5 * 12) / 4)
        if button == "0" {
            return num * 2
        }
        
        return num
    }
    
    private func buttonHeight() -> CGFloat {
        let num = 100.0//(UIScreen.main.bounds.width - 5 * 12) / 4
        return num
    }
    private func buttonColor(_ button: String) -> Color {
        switch button {
        case "0"..."9", ".":
            return Color(.darkGray)
        case "AC", "+/_", "%":
            return Color(.lightGray)
        case "÷", "×", "-", "+", "=":
            return Color(.orange)
        default:
            return Color(.darkGray)
        }
    }
    private func buttonTextColor(_ button: String) -> Color {
        switch button {
        case "0"..."9", ".":
            return Color(.white)
        case "AC", "+/_", "%":
            return Color(.black)
        case "÷", "×", "-", "+", "=":
            return Color(.white)
        default:
            return Color(.white)
        }
    }
}


