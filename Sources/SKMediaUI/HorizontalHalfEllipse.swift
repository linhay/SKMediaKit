//
//  HorizontalHalfEllipse.swift
//  SKMediaKit
//
//  Created by linhey on 4/15/25.
//


struct HorizontalHalfEllipse: Shape {
    enum HalfEllipseDirection {
        case left
        case right
    }

    var direction: HalfEllipseDirection

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        if direction == .right {
            path.move(to: CGPoint(x: 0, y: 0))                   // 左上角
            path.addCurve(to: CGPoint(x: 0, y: height),          // 左下角
                          control1: CGPoint(x: width, y: 0),     // 控制点1
                          control2: CGPoint(x: width, y: height)) // 控制点2
            path.addLine(to: CGPoint(x: 0, y: height))           // 回到底边
            path.closeSubpath()
        } else {
            path.move(to: CGPoint(x: width, y: 0))               // 右上角
            path.addCurve(to: CGPoint(x: width, y: height),     // 右下角
                          control1: CGPoint(x: 0, y: 0),
                          control2: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: width, y: height))
            path.closeSubpath()
        }

        return path
    }
}
