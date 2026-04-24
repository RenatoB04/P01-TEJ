import SpriteKit

class GameOverOverlay: SKNode {
    
    private let sceneSize: CGSize
    
    init(sceneSize: CGSize, score: Int, highScore: Int, isNewRecord: Bool) {
        self.sceneSize = sceneSize
        super.init()
        
        self.name = NodeNames.gameOverOverlay
        self.zPosition = 1000
        
        setupBackground()
        setupLabels(score: score, highScore: highScore, isNewRecord: isNewRecord)
        setupButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupBackground() {
        let background = SKSpriteNode(color: .black, size: sceneSize)
        background.alpha = 0.65
        background.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height / 2)
        background.zPosition = 0
        addChild(background)
    }
    
    private func setupLabels(score: Int, highScore: Int, isNewRecord: Bool) {
        let title = SKLabelNode(fontNamed: "AvenirNext-Bold")
        title.text = "Game Over"
        title.fontSize = 44
        title.fontColor = .white
        title.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height * 0.72)
        title.zPosition = 1
        addChild(title)
        
        let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        scoreLabel.text = "Distance: \(score) m"
        scoreLabel.fontSize = 26
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height * 0.6)
        scoreLabel.zPosition = 1
        addChild(scoreLabel)
        
        let highLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        if isNewRecord {
            highLabel.text = "✨ New Record! ✨"
            highLabel.fontColor = .yellow
        } else {
            highLabel.text = "Record: \(highScore) m"
            highLabel.fontColor = .lightGray
        }
        highLabel.fontSize = 20
        highLabel.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height * 0.53)
        highLabel.zPosition = 1
        addChild(highLabel)
    }
    
    private func setupButtons() {
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 50
        let buttonY = sceneSize.height * 0.35
        
        let retryButton = makeButton(
            text: "Play Again",
            size: CGSize(width: buttonWidth, height: buttonHeight),
            color: .systemGreen,
            name: NodeNames.retryButton
        )
        retryButton.position = CGPoint(x: sceneSize.width / 2, y: buttonY)
        addChild(retryButton)
        
        let menuButton = makeButton(
            text: "Menu",
            size: CGSize(width: buttonWidth, height: buttonHeight),
            color: .systemGray,
            name: NodeNames.menuButton
        )
        menuButton.position = CGPoint(x: sceneSize.width / 2, y: buttonY - 70)
        addChild(menuButton)
    }
    
    private func makeButton(text: String, size: CGSize, color: SKColor, name: String) -> SKSpriteNode {
        let button = SKSpriteNode(color: color, size: size)
        button.name = name
        button.zPosition = 1
        
        let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
        label.text = text
        label.fontSize = 18
        label.fontColor = .white
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = .zero
        label.zPosition = 1
        button.addChild(label)
        
        return button
    }
    
    func buttonName(at location: CGPoint) -> String? {
        let nodes = self.nodes(at: location)
        for node in nodes {
            if node.name == NodeNames.retryButton || node.name == NodeNames.menuButton {
                return node.name
            }
        }
        return nil
    }
}
