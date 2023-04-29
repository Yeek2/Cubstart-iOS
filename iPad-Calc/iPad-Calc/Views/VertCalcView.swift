//
//  VertCalcView.swift
//  iPad-Calc
//
//  Created by Kevin Yee on 4/22/23.
//

import SwiftUI

struct VertCalcView: View {
    var body: some View {
        VStack{
            Spacer()
//            Text("0")
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.white)
                .font(.system(size:172, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.2)
            //colorOfNums need to be set to the right color
            //colorOF3 also but now we can customize the colors
            ButtonPadVert()
        }
        .background(Color.black)
    }
}

struct VertCalcView_Previews: PreviewProvider {
    static var previews: some View {
        VertCalcView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
