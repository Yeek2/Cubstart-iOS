//
//  ButtonPadVert.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/24/23.
//

import SwiftUI

struct ButtonPadVert: View {
    var colorOfOps : Color
    var colorOfNums : Color
    var colorOf3 : Color
    
    var body: some View {

        VStack {
            HStack {
                CircleButtonVert(title: "AC", action: {}, color: colorOf3, textColor: Color.black)
                CircleButtonVert(title: "+/_", action: {}, color: colorOf3, textColor: Color.black)
                CircleButtonVert(title: "%", action: {}, color: colorOf3, textColor: Color.black)
                CircleButtonVert(title: "÷", action: {}, color: colorOfOps, textColor: Color.white)
            }
            HStack {
                CircleButtonVert(title: "7", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "8", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "9", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "×", action: {}, color: colorOfOps, textColor: Color.white)
            }
            HStack {
                CircleButtonVert(title: "4", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "5", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "6", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "-", action: {}, color: colorOfOps, textColor: Color.white)
            }
            HStack {
                CircleButtonVert(title: "1", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "2", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "3", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "+", action: {}, color: colorOfOps, textColor: Color.white)
            }
            HStack {
                //need to see if there is another way for the width
                // also 0 is not the same as figma prototype position
                Button(action: {}) {
                    Text("0")
                        .frame(width: 335, height: 150)
                        .font(.system(size: 60))
                        .padding()
                        .background(colorOfNums)
                        .foregroundColor(Color.white)
                        .cornerRadius(100)
                }
                CircleButtonVert(title: ".", action: {}, color: colorOfNums, textColor: Color.white)
                CircleButtonVert(title: "=", action: {}, color: colorOfOps, textColor: Color.white)
            }
        }
    }
}
