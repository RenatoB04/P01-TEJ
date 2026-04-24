//
//  Constants.swift
//  P01-TEJ
//
//  Created by Aluno a27945 Teste on 24/04/2026.
//

import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let player: UInt32 = 0b1
    static let obstacle: UInt32 = 0b10
}

struct GameConfig {
    static let gravity: CGFloat = -7.0
    static let thrustForce: CGFloat = 140.0
    static let maxVelocity: CGFloat = 300.0
    static let spawnRate: TimeInterval = 1.5
    static let scoreMultiplier: CGFloat = 10.0
}

struct StorageKeys {
    static let highScore = "astroDrift.highScore"
}

struct NodeNames {
    static let retryButton = "retryButton"
    static let menuButton = "menuButton"
    static let gameOverOverlay = "gameOverOverlay"
}
    
    struct StarFieldConfig {
        static let farLayerSpeed: CGFloat = 20.0
        static let midLayerSpeed: CGFloat = 50.0
        static let nearLayerSpeed: CGFloat = 100.0
        
        static let farStarCount: Int = 40
        static let midStarCount: Int = 25
        static let nearStarCount: Int = 15
        
        static let farStarSize: CGFloat = 1.0
        static let midStarSize: CGFloat = 2.0
        static let nearStarSize: CGFloat = 3.0
    }
