import UIKit

class CardBehavior: UIDynamicBehavior {
    lazy var collisionBehavior: UICollisionBehavior = {
        $0.translatesReferenceBoundsIntoBoundary = true
        return $0
    }(UICollisionBehavior())

    lazy var itemBehavior: UIDynamicItemBehavior = {
        $0.allowsRotation = false
        $0.elasticity = 1.0
        $0.resistance = 0
        return $0
    }(UIDynamicItemBehavior())

    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }

    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }

    var angle: CGFloat {
        CGFloat.pi * CGFloat(Int.random(in: 0..<90)) / 180.0
    }
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        print(angle)
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y < center.y:
                push.angle = angle
            case let (x, y) where x > center.x && y < center.y:
                push.angle = CGFloat.pi - angle
            case let (x, y) where x < center.x && y > center.y:
                push.angle = -angle
            case let (x, y) where x > center.x && y > center.y:
                push.angle = CGFloat.pi + angle
            default: push.angle = CGFloat.pi * CGFloat(Int.random(in: 0..<360)) / 180
            }
        }
        push.magnitude = 1.0 + 0.1 * CGFloat(Int.random(in: 0..<20))
        push.action = {[unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }

    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }

    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
