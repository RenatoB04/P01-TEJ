import SpriteKit

class StarField: SKNode {
    
    private let sceneSize: CGSize
    private var farLayer: SKNode!
    private var midLayer: SKNode!
    private var nearLayer: SKNode!
    
    init(sceneSize: CGSize, view: SKView) {
        self.sceneSize = sceneSize
        super.init()
        
        self.zPosition = -100
        
        farLayer = buildLayer(
            view: view,
            starCount: StarFieldConfig.farStarCount,
            starSize: StarFieldConfig.farStarSize,
            color: SKColor(white: 0.4, alpha: 1.0)
        )
        
        midLayer = buildLayer(
            view: view,
            starCount: StarFieldConfig.midStarCount,
            starSize: StarFieldConfig.midStarSize,
            color: SKColor(white: 0.7, alpha: 1.0)
        )
        
        nearLayer = buildLayer(
            view: view,
            starCount: StarFieldConfig.nearStarCount,
            starSize: StarFieldConfig.nearStarSize,
            color: SKColor(white: 1.0, alpha: 1.0)
        )
        
        addChild(farLayer)
        addChild(midLayer)
        addChild(nearLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildLayer(view: SKView, starCount: Int, starSize: CGFloat, color: SKColor) -> SKNode {
        let layer = SKNode()
        
        let texture = makeStarTileTexture(
            view: view,
            starCount: starCount,
            starSize: starSize,
            color: color
        )
        
        let tileA = SKSpriteNode(texture: texture)
        tileA.anchorPoint = CGPoint(x: 0, y: 0)
        tileA.position = CGPoint(x: 0, y: 0)
        layer.addChild(tileA)
        
        let tileB = SKSpriteNode(texture: texture)
        tileB.anchorPoint = CGPoint(x: 0, y: 0)
        tileB.position = CGPoint(x: sceneSize.width, y: 0)
        layer.addChild(tileB)
        
        return layer
    }
    
    private func makeStarTileTexture(view: SKView, starCount: Int, starSize: CGFloat, color: SKColor) -> SKTexture {
        let tileNode = SKNode()
        
        for _ in 0..<starCount {
            let star = SKSpriteNode(color: color, size: CGSize(width: starSize, height: starSize))
            star.position = CGPoint(
                x: CGFloat.random(in: 0...sceneSize.width),
                y: CGFloat.random(in: 0...sceneSize.height)
            )
            tileNode.addChild(star)
        }
        
        let rect = CGRect(x: 0, y: 0, width: sceneSize.width, height: sceneSize.height)
        let texture = view.texture(from: tileNode, crop: rect) ?? SKTexture()
        texture.filteringMode = .nearest
        return texture
    }
    
    func update(deltaTime: TimeInterval, speedMultiplier: CGFloat) {
        scrollLayer(farLayer, speed: StarFieldConfig.farLayerSpeed * speedMultiplier, deltaTime: deltaTime)
        scrollLayer(midLayer, speed: StarFieldConfig.midLayerSpeed * speedMultiplier, deltaTime: deltaTime)
        scrollLayer(nearLayer, speed: StarFieldConfig.nearLayerSpeed * speedMultiplier, deltaTime: deltaTime)
    }
    
    private func scrollLayer(_ layer: SKNode, speed: CGFloat, deltaTime: TimeInterval) {
        let delta = speed * CGFloat(deltaTime)
        
        for child in layer.children {
            child.position.x -= delta
            
            if child.position.x <= -sceneSize.width {
                child.position.x += sceneSize.width * 2
            }
        }
    }
}
