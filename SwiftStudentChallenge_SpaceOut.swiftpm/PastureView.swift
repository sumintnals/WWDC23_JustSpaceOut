//
//  pastureView.swift
//  SwiftStudentChallenge
//
//  Created by 장수민 on 2023/04/06.
//

import SwiftUI
import SpriteKit
import AVFoundation

class PastureScene: SKScene {
    
    let maxSheepCount = 24
    var sheepNodes : [SKSpriteNode] = []
    // touchesBegan: reset when touch
    var textNode : [SKLabelNode] = []
    let resetButton = SKSpriteNode(imageNamed: "wolf")
    
    

    override func didMove(to view: SKView) {
        
        SoundManager.instance.playSound(sound: .NightSound)
        SoundManager.instance.player?.numberOfLoops = 50
        SoundManager.instance.player?.volume = 0.3
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        let pastureBackgroundNode = SKSpriteNode(imageNamed: "nightSky")
        pastureBackgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        pastureBackgroundNode.zPosition = -1
        addChild(pastureBackgroundNode)
        
        resetButton.name = "reset"
        resetButton.position = CGPoint(x: 683, y: 970)
        addChild(resetButton)
        resetButton.zPosition = 31
        resetButton.physicsBody = SKPhysicsBody(rectangleOf: resetButton.size)
        resetButton.physicsBody?.isDynamic = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}  //  guard: 조건이 참이 아닌 경우 조기에 함수, 메서드 또는 블록에서 빠져나오게 하는 제어문
        let location = touch.location(in: self)
        
        let sheepTexture = SKTexture(imageNamed: "sheep")
        let sheep = SKSpriteNode(texture: sheepTexture, color: .clear, size: sheepTexture.size())
        let maxText = SKLabelNode(fontNamed: "나눔손글씨 가람연꽃")
        
        maxText.isUserInteractionEnabled = true
        maxText.zPosition = 30


 // reset button
        
        if let node = atPoint(location) as? SKSpriteNode, node == resetButton {
            for sheep in sheepNodes {
                sheep.removeFromParent()
            }
            sheepNodes.removeAll()
            
            for text in textNode {
                text.removeFromParent()
            }
            textNode.removeAll()
            
            SoundEffectManager.instance.playSound(sound: .PopUPSound)
            return
        }


        if sheepNodes.count <= maxSheepCount {
            sheep.position = location
            sheep.physicsBody = SKPhysicsBody(rectangleOf: sheepTexture.size())
            sheep.physicsBody?.isDynamic = true
            sheep.physicsBody?.friction = 0.0
            sheep.physicsBody?.velocity = CGVector(dx: Int.random(in: -100...100), dy: Int.random(in: -100...100))
            addChild(sheep)
            sheepNodes.append(sheep)
            SoundEffectManager.instance.playSound(sound: .SheepSound)
            SoundEffectManager.instance.player?.volume = 0.3
            
            
        } else {
            
            // count limit
            if textNode.count == 0 {
                
                maxText.text = "Too many sheep may interfere with your Space out!"
                maxText.horizontalAlignmentMode = .center
                maxText.fontColor = UIColor(named: "WarningRed")
                maxText.position = location
                maxText.physicsBody = SKPhysicsBody(rectangleOf: maxText.frame.size)
                maxText.physicsBody?.isDynamic = true
                maxText.physicsBody?.friction = 0.0
                maxText.physicsBody?.velocity = CGVector(dx: Int.random(in: -100...100), dy: Int.random(in: -100...100))
                
                addChild(maxText)
                textNode.append(maxText)
                SoundEffectManager.instance.playSound(sound: .PopUPSound)
                
            } else {
                if let node = atPoint(location) as? SKLabelNode, node == maxText {
                    node.removeFromParent()
                    if let index = textNode.firstIndex(of: node) {
                        textNode.remove(at: index)
                    }
                    return
                }
                else if let node = textNode.first {
                    node.removeFromParent()
                    textNode.removeFirst()
                }
            }
        }
    }
}

struct PastureView: View {
    
    var pastureScene: SKScene {
        
        let pastureScene = PastureScene()
        pastureScene.size = UIScreen.main.bounds.size
        pastureScene.scaleMode = .fill
        
        return pastureScene
    }
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader {
                
                let size = $0.size
                
                ZStack {
                    SpriteView(scene: pastureScene)
                        .frame(width: size.width, height: size.height )
                    
                    NavigationViewComponent(rightDestination: RainUmbrellaView(), size: size)
                }
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                SoundManager.instance.playSound(sound: .NightSound)
                SoundManager.instance.player?.numberOfLoops = 50
                SoundManager.instance.player?.volume = 0.2
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }

}
    


struct pastureView_Previews: PreviewProvider {
    static var previews: some View {
        PastureView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
