import QuartzCore
import CoreGraphics

public class CGShapeUtil {
   /**
    * polyline
    */
   public static func drawPolyLine(shapeLayer:CAShapeLayer, points:[CGPoint],style:(fillColor:Color?,strokeColor:Color?,thickness:CGFloat?)?, close:Bool = false) -> CAShapeLayer{
      let path:CGMutablePath = CGPathParser.polyLine(points: points,close:close)
      shapeLayer.path = path/*Setup the CAShapeLayer with the path, colors, and line width*/
      shapeLayer.strokeColor = style?.strokeColor?.cgColor
      shapeLayer.lineWidth = style?.thickness ?? shapeLayer.lineWidth
      shapeLayer.fillColor = style?.fillColor?.cgColor
      return shapeLayer
   }
   /**
    * Draw line
    * NOTE: remember to: shapeLayer.addSublayer(lineLayer)
    * It's also possible to do this with UIBezierPath
    * let path:UIBezierPath = {
    *    let aPath = UIBezierPath.init()//cgPath: linePath
    *    aPath.move(to: p1)
    *    aPath.addLine(to: p2)
    *    aPath.close()//Keep using the method addLineToPoint until you get to the one where about to close the path
    *    return aPath
    * }()
    */
   static func drawLine( lineLayer:CAShapeLayer, line:(p1:CGPoint, p2:CGPoint), style:(stroke:Color,strokeWidth:CGFloat)) -> CAShapeLayer{
      let path:CGMutablePath = CGMutablePath()
      path.move(to: line.p1)
      path.addLine(to: line.p2)
      lineLayer.path = path/*Setup the CAShapeLayer with the path, colors, and line width*/
      lineLayer.strokeColor = style.stroke.cgColor
      lineLayer.lineWidth = style.strokeWidth
      lineLayer.lineCap = .round
      return lineLayer
   }
   /**
    * Draws circle
    * PARAM: progress: 0-1
    */
//   static func drawCircle(with circleLayer:CAShapeLayer, circle:(center:CGPoint,radius:CGFloat), style:(fill:Color, stroke:Color, strokeWidth:CGFloat), progress:CGFloat) -> CAShapeLayer{
//      let circlePath = UIBezierPath(arcCenter: CGPoint(x: circle.center.x, y: circle.center.y), radius:circle.radius, startAngle: CGFloat(Double.pi * -0.5), endAngle: CGFloat(Double.pi * 1.5), clockwise: true)/*The path should be the entire circle, for the strokeEnd and strokeStart to work*/
//      circleLayer.path = circlePath.cgPath/*Setup the CAShapeLayer with the path, colors, and line width*/
//      circleLayer.fillColor = style.fill.cgColor
//      circleLayer.strokeColor = style.stroke.cgColor
//      circleLayer.lineWidth = style.strokeWidth
//      circleLayer.lineCap = .round
//      circleLayer.strokeEnd = progress/*Sets progress of the stroke between predefined start and predefined end*/
//      return circleLayer
//   }
}
