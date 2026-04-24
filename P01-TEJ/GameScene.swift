//
//  GameScene.swift
//  P01-TEJ
//
//  Created by VM on 11/04/2026.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let player = PlayerNode()
    let spawner = ObstacleSpawner()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        self.size = view.bounds.size
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: GameConfig.gravity)
        self.physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: size.width * 0.2, y: size.height / 2)
        
        if player.parent == nil {
            addChild(player)
        }
        
        startSpawning()
    }
    
    func startSpawning() {
        self.removeAction(forKey: "spawnLoop")
        let wait = SKAction.wait(forDuration: GameConfig.spawnRate)
        let spawn = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.spawner.spawn(in: self)
        }
        let sequence = SKAction.sequence([wait, spawn])
        run(SKAction.repeatForever(sequence), withKey: "spawnLoop")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.physicsBody?.velocity = CGVector.zero
        player.applyThrust()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let transition = SKTransition.doorway(withDuration: 0.8)
        let menu = MenuScene(size: self.size)
        menu.scaleMode = .aspectFill
        self.view?.presentScene(menu, transition: transition)
    }
}
