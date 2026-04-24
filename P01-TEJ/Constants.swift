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
}
