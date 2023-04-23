//
//  ShortButton.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/23/23.
//

import SwiftUI

struct ShortButton: View {
    var title: String
    var action: () -> Void
    var color: Color
    var textColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: 150, height: 150)
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .background(color)
                .foregroundColor(textColor)
                .clipShape(Circle())
        }
    }
}
