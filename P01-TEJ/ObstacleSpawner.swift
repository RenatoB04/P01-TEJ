//
//  ObstacleSpawner.swift
//  P01-TEJ
//
//  Created by Aluno a27945 Teste on 24/04/2026.
//

import SpriteKit

class ObstacleSpawner {
    func spawn(in scene: SKScene) {
        let obstacle = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 30))
        obstacle.name = "obstacle"
        
        let randomY = CGFloat.random(in: 50...scene.size.height - 50)
        obstacle.position = CGPoint(x: scene.size.width + 50, y: randomY)
        
        obstacle.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        
        scene.addChild(obstacle)
        
        let moveAction = SKAction.moveTo(x: -50, duration: 3.5)
        let removeAction = SKAction.removeFromParent()
        obstacle.run(SKAction.sequence([moveAction, removeAction]))
    }
}
