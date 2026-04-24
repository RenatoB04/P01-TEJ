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
    
    var isThrusting = false

    private var score: Int = 0
    private var lastUpdateTime: TimeInterval = 0
    private var elapsedTime: TimeInterval = 0
    private let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        self.size = view.bounds.size
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: GameConfig.gravity)
        self.physicsWorld.contactDelegate = self
        
        player.position = CGPoint(x: size.width * 0.2, y: size.height / 2)
        
        if player.parent == nil {
            addChild(player)
        }
        
        setupHUD()
        startSpawning()
    }
    
    private func setupHUD() {
        scoreLabel.text = "0 m"
        scoreLabel.fontSize = 28
        scoreLabel.fontColor = .white
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: size.width - 20, y: size.height - 50)
        scoreLabel.zPosition = 100
        addChild(scoreLabel)
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
        isThrusting = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isThrusting = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isThrusting = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
        }
        let dt = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        elapsedTime += dt
        score = Int(elapsedTime * TimeInterval(GameConfig.scoreMultiplier))
        scoreLabel.text = "\(score) m"

        if isThrusting {
            player.physicsBody?.applyForce(CGVector(dx: 0, dy: GameConfig.thrustForce))
            
            if let velocityY = player.physicsBody?.velocity.dy, velocityY > GameConfig.maxVelocity {
                player.physicsBody?.velocity.dy = GameConfig.maxVelocity
            }
        }
        
        if player.position.y > size.height - 20 {
            player.position.y = size.height - 20
            player.physicsBody?.velocity.dy = 0
        }
        
        if player.position.y < 20 {
            player.position.y = 20
            player.physicsBody?.velocity.dy = 0
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        saveHighScoreIfNeeded()
        
        let transition = SKTransition.doorway(withDuration: 0.8)
        let menu = MenuScene(size: self.size)
        menu.scaleMode = .aspectFill
        menu.lastScore = score   // passar para o menu
        self.view?.presentScene(menu, transition: transition)
    }
    
    private func saveHighScoreIfNeeded() {
        let defaults = UserDefaults.standard
        let currentHigh = defaults.integer(forKey: StorageKeys.highScore)
        if score > currentHigh {
            defaults.set(score, forKey: StorageKeys.highScore)
        }
    }
}
