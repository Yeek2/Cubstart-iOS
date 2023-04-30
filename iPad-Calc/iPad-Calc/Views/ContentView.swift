//
//  ContentView.swift
//  iPad-Calc
//
//  Created by Jeffrey Millan on 4/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        
        Group {
            if orientation.isLandscape {
                ButtonPadHorz()
            } else {
                ButtonPadVert()
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                orientation = UIDevice.current.orientation
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
