import SpriteKit

class ObstacleSpawner {
    func spawn(in scene: SKScene, moveDuration: TimeInterval) {
        let size = CGSize(width: 30, height: 30)
        let obstacle = SKSpriteNode(color: .red, size: size)
        obstacle.name = "obstacle"
        
        let randomY = CGFloat.random(in: 50...scene.size.height - 50)
        obstacle.position = CGPoint(x: scene.size.width + 50, y: randomY)
        
        obstacle.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        
        scene.addChild(obstacle)
        
        let moveAction = SKAction.moveTo(x: -50, duration: moveDuration)
        let removeAction = SKAction.removeFromParent()
        obstacle.run(SKAction.sequence([moveAction, removeAction]))
    }
}
