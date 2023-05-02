//
//  ButtonPadVert.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/29/23.
// 10+10+10== --->40 on iphone calculator
// 10+10+10== ----> 50 on ours but I think its fine most people wont do double == i think

import SwiftUI

enum Operation {
    case none, add, subtract, multiply, divide
}

struct ButtonPadVert: View {
    @State private var currentNumber: String = "0"
    @State private var displayNumber: String = "0"
    @State private var storedNumber: Double = 0
    @State private var operation: Operation = .none
    @State private var isDoingOp = false
    
    let buttons = [
        ["AC", "+/_", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    var body: some View {
        
        VStack(spacing: 14) {
            Spacer()
            
            Text(displayNumber)
                .font(.system(size: 150))
                .foregroundColor(.white)
                .padding(.trailing, 250)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack(spacing: 12) {
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.buttonTapped(button)
                            }) {
                                Text(button)
                                    .font(.system(size: 48))
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
        default:
            if let number = Int(button) {
                appendNumber(number)
            } else if button == "." {
                appendDecimal()
            }
        }
    }
    
    private func appendNumber(_ number: Int) {
        if currentNumber == "0" {
            currentNumber = String(number)
        } else {
            currentNumber.append(String(number))
        }
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
    }
    
    private func appendDecimal() {
        if currentNumber.contains(".") {
            return
        }
        
        currentNumber.append(".")
        displayNumber = currentNumber
        displayNumber = shortenString(s: displayNumber)
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
        displayNumber = shortenString(s: displayNumber)
        storedNumber = Double(currentNumber)!
        currentNumber = "0"
        self.isDoingOp = true
    }
    private func shortenString(s : String) -> String {
        let trimToCharacter = 7
        let trimToCharacter2 = 5
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
        let num = 150.0//((UIScreen.main.bounds.width - 5 * 12) / 4)
        if button == "0" {
            return num * 2
        }
        
        return num
    }
    
    private func buttonHeight() -> CGFloat {
        let num = 150.0//(UIScreen.main.bounds.width - 5 * 12) / 4
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


