//  ShortButton.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/23/23.
//

import SwiftUI

struct CircleButtonVert: View {
    var title: String
    var action: () -> Void
    var color: Color
    var textColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 150, height: 150)
                .font(.system(size: 60))
                .padding()
                .background(color)
                .foregroundColor(textColor)
                .clipShape(Circle())
        }
    }
}
