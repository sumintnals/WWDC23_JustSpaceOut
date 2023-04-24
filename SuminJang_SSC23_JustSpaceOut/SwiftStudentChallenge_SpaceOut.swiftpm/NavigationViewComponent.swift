//
//  NavigationViewComponent.swift
//  SwiftStudentChallenge
//
//  Created by 장수민 on 2023/04/20.
//

import SwiftUI

struct NavigationViewComponent<Destination2: View>: View {
    
//    let leftDestination: Destination1
    let rightDestination: Destination2
    let size: CGSize // size
    
    var body: some View {
        HStack {
//            NavigationLink(destination: leftDestination) {
//                Image(systemName: "arrow.left")
//                    .foregroundColor(Color.warningRed)
//                    .frame(width: size.width / 45, height: size.height / 45)
//            }
//            .background(Color.clear)
//            .position(x: size.width / 45, y: size.height / 34)
            
            NavigationLink(destination: rightDestination) {
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.warningRed)
                    .frame(width: size.width / 45, height: size.height / 45)
            }
            .background(Color.clear)
            .position(x: size.width / 1.03, y: size.height / 34)
        }
    }
}



