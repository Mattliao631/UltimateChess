

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    let localGameLabel = SKLabelNode(text: "Local Game")
    let onlineGameLabel = SKLabelNode(text: "Play Online")
    
    override func didMove(to view: SKView) {
        localGameLabel.horizontalAlignmentMode = .center
        localGameLabel.verticalAlignmentMode = .center
        onlineGameLabel.horizontalAlignmentMode = .center
        onlineGameLabel.verticalAlignmentMode = .center
        
        localGameLabel.fontSize = 45
        localGameLabel.fontColor = SKColor.black
        localGameLabel.fontName = "Avenir"
        
        let localGame = SKSpriteNode(color: UIColor.white, size: CGSize(width: size.width * 0.7, height: size.height * 0.1))
        localGame.zPosition = -1
        localGame.addChild(localGameLabel)
        localGame.position = CGPoint(x: view.frame.midX, y: view.frame.height * 2 / 3)
        localGame.name = "Local_Game"
        localGame.children[0].name = localGame.name
        
        onlineGameLabel.fontSize = 45
        onlineGameLabel.fontColor = SKColor.black
        onlineGameLabel.fontName = "Avenir"
        
        let onlineGame = SKSpriteNode(color: UIColor.white, size: CGSize(width: size.width * 0.7, height: size.height * 0.1))
        onlineGame.zPosition = -1
        onlineGame.addChild(onlineGameLabel)
        onlineGame.position = CGPoint(x: view.frame.midX, y: view.frame.height / 3)
        onlineGame.name = "Online_Game"
        onlineGame.children[0].name = onlineGame.name
        
        
        self.addChild(localGame)
        self.addChild(onlineGame)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if let nodeName = touchedNode.name {
                switch nodeName {
                case "Local_Game":
                    let localGameScene = LocalGameScene(size: self.size)
                    localGameScene.scaleMode = self.scaleMode
                    let trans = SKTransition.crossFade(withDuration: 1)
                    self.view?.presentScene(localGameScene, transition: trans)
                    self.removeFromParent()
                    break
                    
                case "Online_Game":
                    let alert = UIAlertController(title: "Coming Soon", message: "Online mode will be available soon.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.view?.window?.rootViewController?.present(alert, animated: true)
                    break
                default:
                    break
                }
            }
        }
    }
}
