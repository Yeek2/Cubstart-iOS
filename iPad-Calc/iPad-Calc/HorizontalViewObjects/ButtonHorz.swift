//
//  ButtonHorz.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/24/23.
//

import SwiftUI

struct ButtonHorz: View {
    var title: String
    var action: () -> Void
    var color: Color
    var textColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 70, height: 60)
                .font(.system(size: 32))
                .padding()
                .background(color)
                .foregroundColor(textColor)
                .cornerRadius(100)
        }
    }
}
