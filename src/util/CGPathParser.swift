import UIKit

class CGPathParser{
   /**
    * Returns a path with straight lines derived from an array of points (think follow the dots)
    * TODO: ⚠️️ shouldn't this path be closed by a real close call?
    * NOTE: effectivly it creates a PolyLine,
    * EXAMPLE:
    * let triangle = TriangleMath.equilateralTriangle(height: 100)
    * let points:[CGPoint] = [triangle.a,triangle.b,triangle.c]
    * let cgPath = CGPathParser.polyLine(points:points, close: true)
    * let shapeLayer:CAShapeLayer = .init()
    * CGPathModifier.fill(shape: shapeLayer, cgPath: cgPath, fillColor: .green)
    * self.view.layer.addSublayer(shapeLayer)
    */
   static func polyLine(points:[CGPoint], close:Bool = false, offset:CGPoint = .init(x:0,y:0)) -> CGMutablePath{
      let path:CGMutablePath = CGMutablePath()
      if points.count > 0 { path.move(to: CGPoint(x:points[0].x+offset.x, y:points[0].y+offset.y))}
      for i in 1..<points.count{
         //Swift.print("LineTo: x:  \(points[i].x+offset.x) y:  \(points[i].y+offset.y)")
         path.addLine(to: CGPoint(x:points[i].x+offset.x, y:points[i].y+offset.y))
      }
      if close {
         path.addLine(to: CGPoint(x:points[0].x+offset.x, y:points[0].y+offset.y))/*closes it self to the start position*/
         path.closeSubpath()/*it may not be necessary to have the above line when you call this method*/
      }
      return path
   }
}
