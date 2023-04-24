//
//  WindChimeView.swift
//  SwiftStudentChallenge
//
//  Created by 장수민 on 2023/04/12.
//

import SwiftUI
import SpriteKit
import AVFoundation

class WindChime : SKScene {
    override func didMove(to view: SKView) {
   
    }
}

struct WindChimeView: View {
    
    @State private var isClicked = false
    
    var body: some View {
        NavigationView {
            
            GeometryReader {
                
                let size = $0.size
                
                ZStack {
                    
                    VStack {
                        HStack {
                        if isClicked {
                            
                            Image("Push")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width / 3)
                                .onTapGesture {
                                    self.isClicked.toggle()
                                    SoundEffectManager.instance.playSound(sound: .PopSound)
                                }
                            
                        } else {
                            
                            Image("Pop")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width / 3)
                                .onTapGesture {
                                    self.isClicked.toggle()
                                    SoundEffectManager.instance.playSound(sound: .PushSound)
                                }
                        }
                    }  // H

                }  // V
                    
                    NavigationViewComponent(rightDestination: PastureView(), size: size)
                }
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                SoundManager.instance.player?.stop()
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}

struct WindChimeView_Previews: PreviewProvider {
    static var previews: some View {
        WindChimeView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
