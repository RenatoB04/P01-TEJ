//
//  PlayerNode.swift
//  P01-TEJ
//
//  Created by Aluno a27945 Teste on 24/04/2026.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    init() {
        let size = CGSize(width: 40, height: 40)
        super.init(texture: nil, color: .cyan, size: size)
        
        self.name = "player"
        setupPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
    }
}
