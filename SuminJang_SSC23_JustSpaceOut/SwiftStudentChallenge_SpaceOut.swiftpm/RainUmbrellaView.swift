//
//  RainUmbrellaView.swift
//  SwiftStudentChallenge
//
//  Created by 장수민 on 2023/04/12.
//

import SwiftUI
import SpriteKit
import AVFoundation

class RainUmbrellaScene : SKScene, SKPhysicsContactDelegate {
    
    var umbrella = SKSpriteNode()
    var smallLeaf = SKSpriteNode()
    var smallStem = SKSpriteNode()
    var bigLeaf = SKSpriteNode()
    var bigStem = SKSpriteNode()
    var rainBackgroundNode = SKSpriteNode()
    
    var isFolded: Bool = false

    override func didMove(to view: SKView) {
        
        SoundManager.instance.playSound(sound: .RainSound)
        SoundManager.instance.player?.numberOfLoops = 2
        
        super.didMove(to: view)
        scaleMode = .resizeFill
        backgroundColor = UIColor.clear
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        rainBackgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "rainingBackground"))
        rainBackgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
        rainBackgroundNode.zPosition = -1
        addChild(rainBackgroundNode)

        umbrella = SKSpriteNode(texture: SKTexture(imageNamed: "umbrella"), color: .clear, size: SKTexture(imageNamed: "umbrella").size())
        
        umbrella.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "umbrella"), size: SKTexture(imageNamed: "umbrella").size())
        umbrella.position = CGPoint(x: 0.5, y: 0.5)
        umbrella.name = "umbrella"
        umbrella.physicsBody?.isDynamic = false
        umbrella.zPosition = 1

        addChild(umbrella)

        let smallLeafTexture = SKTexture(imageNamed: "bigLeaf")
        smallLeaf = SKSpriteNode(texture: smallLeafTexture, color: .clear, size: smallLeafTexture.size())
        smallLeaf.position = CGPoint(x: -300 , y: -380)
        
        let smallStemTexture = SKTexture(imageNamed: "bigStem")
        smallStem = SKSpriteNode(texture: smallStemTexture, color: .clear, size: smallStemTexture.size())
        smallStem.position = CGPoint(x: -300, y: -454.7)
        
        smallStem.setScale(0.5)
        smallLeaf.setScale(0.5)
        
        let bigLeafTexture = SKTexture(imageNamed: "bigLeaf")
        bigLeaf = SKSpriteNode(texture: bigLeafTexture, color: .clear, size: bigLeafTexture.size())
        bigLeaf.position = CGPoint(x: -550, y: -235.79)
        
        let bigStemTexture = SKTexture(imageNamed: "bigStem")
        bigStem = SKSpriteNode(texture: bigStemTexture, color: .clear, size: bigStemTexture.size())
        bigStem.position = CGPoint(x: -550, y: -372.5)
        
        
        let rotateRight = SKAction.rotate(byAngle: CGFloat.pi/12, duration: 0.3)
        let rotateLeft = SKAction.rotate(byAngle: -CGFloat.pi/12, duration: 0.3)
        let shake1 = SKAction.sequence([rotateRight, rotateLeft, rotateLeft, rotateRight])
        let shake2 = SKAction.sequence([rotateLeft, rotateRight, rotateRight, rotateLeft])
        let repeatShake1 = SKAction.repeatForever(shake1)
        let repeatShake2 = SKAction.repeatForever(shake2)
        
        
        bigLeaf.run(repeatShake1)
        smallLeaf.run(repeatShake2)
        
        addChild(bigStem)
        addChild(bigLeaf)
        addChild(smallLeaf)
        addChild(smallStem)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        
        let rotateRight = SKAction.rotate(byAngle: CGFloat.pi/12, duration: 0.3)
        let rotateLeft = SKAction.rotate(byAngle: -CGFloat.pi/12, duration: 0.3)
        let shake1 = SKAction.sequence([rotateRight, rotateLeft, rotateLeft, rotateRight])
        let shake2 = SKAction.sequence([rotateLeft, rotateRight, rotateRight, rotateLeft])
        let repeatShake1 = SKAction.repeatForever(shake1)
        let repeatShake2 = SKAction.repeatForever(shake2)
        
        let resetRotation = SKAction.run {
            self.bigLeaf.zRotation = 0
            self.smallLeaf.zRotation = 0
        }

        if let umbrellaNode = touchedNode as? SKSpriteNode, umbrellaNode.name == "umbrella" {
            if isFolded {
                umbrellaNode.texture = SKTexture(imageNamed: "umbrella")
                umbrellaNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "umbrella"), size: SKTexture(imageNamed: "umbrella").size())
                umbrellaNode.size = SKTexture(imageNamed: "umbrella").size()
                
                rainBackgroundNode.texture = SKTexture(imageNamed: "rainingBackground")
                
                SoundEffectManager.instance.playSound(sound: .openUmb)
                SoundManager.instance.playSound(sound: .RainSound)
                SoundManager.instance.player?.numberOfLoops = 100
                
                bigLeaf.run(repeatShake1)
                smallLeaf.run(repeatShake2)
                isFolded = false
            } else {
                umbrellaNode.texture = SKTexture(imageNamed: "umbrella_folded")
                umbrellaNode.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "umbrella_folded"), size: SKTexture(imageNamed: "umbrella_folded").size())
                umbrellaNode.size = SKTexture(imageNamed: "umbrella_folded").size()
                rainBackgroundNode.texture = SKTexture(imageNamed: "rainViewBackground")
                
            
                SoundEffectManager.instance.playSound(sound: .closeUmb)
                SoundManager.instance.playSound(sound: .afterRainSound)
                SoundManager.instance.player?.numberOfLoops = 100
              
                bigLeaf.removeAllActions()
                smallLeaf.removeAllActions()
                bigLeaf.run(resetRotation)
                smallLeaf.run(resetRotation)
                isFolded = true
                
            }
        }
    }
}
    

    struct RainUmbrellaView: View {
        
        var rainUmbrellaScene: SKScene {
            let rainUmbrellaScene = RainUmbrellaScene()
            rainUmbrellaScene.size = UIScreen.main.bounds.size
            rainUmbrellaScene.scaleMode = .fill
            
            return rainUmbrellaScene
        }
        
        var body: some View {
            NavigationView {
                
                GeometryReader {
                    
                    let size = $0.size
                    
                    ZStack {
                        SpriteView(scene: rainUmbrellaScene)
                            .frame(width: size.width, height: size.height )
                            .ignoresSafeArea(.all, edges: .all)
                        
                        NavigationViewComponent( rightDestination: WindChimeView(), size: size)                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    SoundManager.instance.playSound(sound: .RainSound)
                    SoundManager.instance.player?.numberOfLoops = 50
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
        }
    }
    
    
    struct RainUmbrellaView_Preview: PreviewProvider {
        static var previews: some View {
            RainUmbrellaView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }

