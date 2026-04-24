//
//  MenuScene.swift
//  P01-TEJ
//
//  Created by Aluno a27945 Teste on 24/04/2026.
//

import SpriteKit

class MenuScene: SKScene {
    
    var lastScore: Int? = nil
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .darkGray
        
        let title = SKLabelNode(text: "Astro Drift")
        title.fontName = "AvenirNext-Bold"
        title.fontSize = 40
        title.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        addChild(title)
        
        let highScore = UserDefaults.standard.integer(forKey: StorageKeys.highScore)
        let highLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        highLabel.text = "Recorde: \(highScore) m"
        highLabel.fontSize = 22
        highLabel.fontColor = .yellow
        highLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.58)
        addChild(highLabel)
        
        if let lastScore = lastScore {
            let lastLabel = SKLabelNode(fontNamed: "AvenirNext")
            lastLabel.text = "Última: \(lastScore) m"
            lastLabel.fontSize = 18
            lastLabel.fontColor = .white
            lastLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.5)
            addChild(lastLabel)
        }
        
        let startLabel = SKLabelNode(text: "Tocar para Jogar")
        startLabel.fontSize = 20
        startLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.3)
        addChild(startLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let game = GameScene(size: self.size)
        game.scaleMode = .aspectFill
        self.view?.presentScene(game, transition: .crossFade(withDuration: 1.0))
    }
}
