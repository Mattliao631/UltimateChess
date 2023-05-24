//
//  GameViewController.swift
//  Ultimate_Chess
//
//  Created by MattLiao on 2023/5/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
           
            let MainMenuScene = MainMenuScene(size: view.frame.size)
            MainMenuScene.scaleMode = .aspectFill
            view.presentScene(MainMenuScene)
           
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

}
