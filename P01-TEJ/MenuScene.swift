//
//  MenuScene.swift
//  P01-TEJ
//
//  Created by Aluno a27945 Teste on 24/04/2026.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = .darkGray
        
        let label = SKLabelNode(text: "Astro Drift")
        label.fontName = "AvenirNext-Bold"
        label.position = CGPoint(x: size.width / 2, y: size.height * 0.6)
        addChild(label)
        
        let startLabel = SKLabelNode(text: "Tocar para Jogar")
        startLabel.fontSize = 20
        startLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.4)
        addChild(startLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let game = GameScene(size: self.size)
        game.scaleMode = .aspectFill
        self.view?.presentScene(game, transition: .crossFade(withDuration: 1.0))
    }
}
