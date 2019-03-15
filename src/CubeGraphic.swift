import QuartzCore
import CoreGraphics

open class CubeGraphic:CAShapeLayer{}

extension CubeGraphic{
   /**
    * drawCube
    */
   public func drawCube(cube:Cube){
      let front:CAShapeLayer = .init()//draw front
      drawQuad(quad: cube.front, polyShape: front, strokeColor: .black)
      self.addSublayer(front)
      let back:CAShapeLayer = .init() //draw back
      drawQuad(quad: cube.back, polyShape: back, strokeColor: .black)
      self.addSublayer(back)
      drawLines(cube: cube)//draw connecting lines
   }
   /**
    * drawQuad
    */
   func drawQuad(quad:Quad,polyShape:CAShapeLayer,strokeColor:Color){
      let corners:[CGPoint] = [quad.p1,quad.p2,quad.p4,quad.p3]
      _ = CGShapeUtil.drawPolyLine(shapeLayer:polyShape, points:corners, style:(fillColor:nil,strokeColor:strokeColor,thickness:1), close:true)
   }
   /**
    * draw connecting lines
    * Abstract: connect the z points to complete the cube
    */
   func drawLines(cube:Cube){
      let lines:[CAShapeLayer] = [.init(),.init(),.init(),.init()]
      let linePoints:[(p1:CGPoint,p2:CGPoint)] = [(cube.front.p1,cube.back.p1),(cube.front.p2,cube.back.p2),(cube.front.p3,cube.back.p3),(cube.front.p4,cube.back.p4)]
      lines.enumerated().forEach{
         _ = CGShapeUtil.drawLine(lineLayer: $0.element, line: linePoints[$0.offset], style: (.black,1))
         self.addSublayer($0.element)
      }
   }
}
