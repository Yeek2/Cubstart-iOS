//
//  ButtonPadVert.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/24/23.
//

import SwiftUI

enum Buttons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case neg = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case .clear, .neg, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, neg, none
}

    
struct ButtonPadVert: View {
//    var colorOfOps : Color
//    var colorOfNums : Color
//    var colorOf3 : Color
    
    @State var currValue = "0"
    @State var nextValue = "0"
    @State var doingOp = false
    @State var mathVal = 0.0
    @State var currOp: Operation = .none

    let buttons: [[Buttons]] = [
        [.clear, .neg, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
           Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Text("Current Value \(currValue)").foregroundColor(.white)
                Text("Next Value \(nextValue)").foregroundColor(.white)
                Text("Math Val \(mathVal)").foregroundColor(.white)
                Text("doing op \(doingOp.description)").foregroundColor(.white)
                HStack {
                    Spacer()
    
                    Text("\(doingOp ? nextValue : currValue)")
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()

                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            CircleButtonVert(title: item.rawValue, action: {self.didTap(button: item)},
                                             textColor: Color.white)
                                .background(item.buttonColor)
                                .cornerRadius(self.buttonW(item: item)/2)
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    func didTap(button: Buttons) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .neg, .equal:
            if button == .add {
                self.currOp = .add
                self.mathVal = Double(self.currValue) ?? 0
                self.doingOp = true
            }
            else if button == .subtract {
                self.currOp = .subtract
                self.mathVal = Double(self.currValue) ?? 0
                self.doingOp = true
            }
            else if button == .mutliply {
                self.currOp = .multiply
                self.mathVal = Double(self.currValue) ?? 0
                self.doingOp = true
            }
            else if button == .divide {
                self.currOp = .divide
                self.mathVal = Double(self.currValue) ?? 0
                self.doingOp = true
            }
            else if button == .neg {
                self.currOp = .neg
                self.mathVal = Double(self.currValue) ?? 0
                self.doingOp = true
            }
            else if button == .equal {
                let mathVal = self.mathVal
                let nextVal = Double(self.nextValue) ?? 0.0
                
                switch self.currOp {
                case .add:
                    self.currValue = "\(mathVal + nextVal)"
                    
                case .subtract:
                    self.currValue = "\(mathVal - nextVal)"
                case .multiply:
                    self.currValue = "\(mathVal * nextVal)"
                case .divide:
                    self.currValue = "\(mathVal / nextVal)"
                case .neg:
                    self.currValue = "\(-1 * mathVal)"
                case .none:
                    break
                }
                self.doingOp = false
                self.nextValue = "0"
            }
            
        case .clear:
            self.currValue = "0"
            self.nextValue = "0"
            self.mathVal = 0.0
            self.doingOp = false
        case .neg: // doesnt change to neg when clicked
            self.currValue = "-\(currValue)"
        case .decimal, .percent:
            break
        default:
            let number = button.rawValue
            
            if doingOp == true {
                if self.nextValue == "0" {
                    self.nextValue = number
                    
                } else {
                    self.nextValue += number
                }
            } else {
                if self.currValue == "0" {
                    self.currValue = number
                    
                } else {
                    self.currValue += number
                }
            }
            
        }
    }

    func buttonW(item: Buttons) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (6*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

}



       
    

//        VStack {
//            HStack {
//                CircleButtonVert(title: "AC", action: { }, color: colorOf3, textColor: Color.black)
//                CircleButtonVert(title: "+/_", action: { }, color: colorOf3, textColor: Color.black)
//                CircleButtonVert(title: "%", action: { }, color: colorOf3, textColor: Color.black)
//                CircleButtonVert(title: "÷", action: { }, color: colorOfOps, textColor: Color.white)
//            }
//            HStack {
//                CircleButtonVert(title: "7", action: {}, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "8", action: { }, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "9", action: { }, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "×", action: { }, color: colorOfOps, textColor: Color.white)
//            }
//            HStack {
//                CircleButtonVert(title: "4", action: { }, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "5", action: { }, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "6", action: { }, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "-", action: { }, color: colorOfOps, textColor: Color.white)
//            }
//            HStack {
//                CircleButtonVert(title: "1", action: {}, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "2", action: {}, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "3", action: {}, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "+", action: {}, color: colorOfOps, textColor: Color.white)
//            }
//            HStack {
//                //need to see if there is another way for the width
//                // also 0 is not the same as figma prototype position
//                Button(action: {}) {
//                    Text("0")
//                        .frame(width: 335, height: 150)
//                        .font(.system(size: 60))
//                        .padding()
//                        .background(colorOfNums)
//                        .foregroundColor(Color.white)
//                        .cornerRadius(100)
//                }
//                CircleButtonVert(title: ".", action: {}, color: colorOfNums, textColor: Color.white)
//                CircleButtonVert(title: "=", action: {}, color: colorOfOps, textColor: Color.white)
//            }
