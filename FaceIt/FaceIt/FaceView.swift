import UIKit

class FaceView: UIView {
    private var skullRadius: CGFloat {
        Ratios.scale * min(bounds.width, bounds.height) / 2
    }

    private var skullCenter: CGPoint {
        CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: skullCenter,
            radius: skullRadius,
            startAngle: 0,
            endAngle: 2 * CGFloat.pi,
            clockwise: false
        )
        path.lineWidth = Ratios.lineWidth
        return path
    }

    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.eyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += eye == .left ? -eyeOffset : eyeOffset
            return eyeCenter
        }

        let eyeRadius = skullRadius / Ratios.eyeRadius
        let eyeCenter = centerOfEye(eye)

        let path: UIBezierPath
        if Ratios.eyesOpen {
            path = UIBezierPath(
                arcCenter: eyeCenter,
                radius: eyeRadius,
                startAngle: 0,
                endAngle: 2 * CGFloat.pi,
                clockwise: false
            )
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = Ratios.lineWidth
        return path
    }

    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.mouthWidth
        let mouthHeight = skullRadius / Ratios.mouthHeight
        let mouthOffset = skullRadius / Ratios.mouthOffset

        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )

        let smileOffset = max(-1, min(Ratios.mouthCurvature, 1)) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        let cp1 = CGPoint(
            x: start.x + mouthRect.width / 3,
            y: start.y + smileOffset
        )
        let cp2 = CGPoint(
            x: end.x - mouthRect.width / 3,
            y: start.y + smileOffset
        )
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = Ratios.lineWidth
        return path
    }

    override func draw(_ rect: CGRect) {
        Ratios.color.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }

    private struct Ratios {
        static let scale = 0.9
        static let color = UIColor.green
        static let eyesOpen = true
        static let lineWidth = 5.0
        static let mouthCurvature = 0.5
        
        static let eyeOffset = 3.0
        static let eyeRadius = 10.0
        static let mouthWidth = 1.0
        static let mouthHeight = 3.0
        static let mouthOffset = 3.0
    }

    private enum Eye {
        case left
        case right
    }
}

#Preview {
    FaceView()
}
