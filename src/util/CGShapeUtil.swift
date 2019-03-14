
import UIKit

class CGShapeUtil {
   /**
    * polyline
    */
   static func drawPolyLine(shapeLayer:CAShapeLayer, points:[CGPoint],style:(fillColor:UIColor?,strokeColor:UIColor?,thickness:CGFloat?)?, close:Bool = false) -> CAShapeLayer{
      let path:CGMutablePath = CGPathParser.polyLine(points: points,close:close)
      shapeLayer.path = path/*Setup the CAShapeLayer with the path, colors, and line width*/
      shapeLayer.strokeColor = style?.strokeColor?.cgColor
      shapeLayer.lineWidth = style?.thickness ?? shapeLayer.lineWidth
      shapeLayer.fillColor = style?.fillColor?.cgColor
      return shapeLayer
   }
}
