//
//  VerticalCalculatorView.swift
//  Calculator
//
//  Created by Kevin Yee on 4/22/23.
//

import SwiftUI

struct VerticalCalculatorView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("0")
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.white)
                .font(.system(size:172, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
            //ButtonPad goes here
        }
        .background(Color.black)
    }
}

struct VerticalCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalCalculatorView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
