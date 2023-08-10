import UIKit

class PlaingCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .redraw
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentMode = .redraw
    }
    override func draw(_ rect: CGRect) {
//        if let context = UIGraphicsGetCurrentContext() {
//            context.addArc(
//                center: CGPoint(x: rect.midX, y: rect.midY),
//                radius: 100,
//                startAngle: 0,
//                endAngle: 2 * CGFloat.pi,
//                clockwise: true)
//            context.setLineWidth(5)
//            UIColor.green.setFill()
//            UIColor.systemPink.setStroke()
//            context.strokePath()
////            context.fillPath()
//        }
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY),
                    radius: 100,
                    startAngle: 0,
                    endAngle: 2 * CGFloat.pi,
                    clockwise: true)
        path.lineWidth = 5
        UIColor.green.setFill()
        UIColor.systemPink.setStroke()
        path.fill()
        path.stroke()
    }

}
