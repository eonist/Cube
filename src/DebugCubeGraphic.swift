import QuartzCore
import CoreGraphics
/**
 * TODO: ⚠️️ group dots and lines together in sublayers to get cleaner code
 */
open class DebugCubeGraphic:CubeGraphic{
   lazy var boxBackCenter:CAShapeLayer = createDot(color:.gray)
   /*back of the box*/
   lazy var boxDot1:CAShapeLayer = createDot(color:.cyan)
   lazy var boxDot2:CAShapeLayer = createDot(color:.blue)
   lazy var boxDot3:CAShapeLayer = createDot(color:.green)
   lazy var boxDot4:CAShapeLayer = createDot(color:.red)
   
   /*front of the box*/
   lazy var boxDot5:CAShapeLayer = createDot(color:.gray)
   lazy var boxDot6:CAShapeLayer = createDot(color:.red)
   lazy var boxDot7:CAShapeLayer = createDot(color:.orange)
   lazy var boxDot8:CAShapeLayer = createDot(color:.purple)
   
   //debug
   lazy var vp1Dot:CAShapeLayer = self.createDot(color:.red)
   lazy var vp2Dot:CAShapeLayer = self.createDot(color:.green)
   lazy var quadCenterDot:CAShapeLayer = self.createDot(color:.green)
   lazy var orthPTDot:CAShapeLayer = self.createDot(color:.red)
   lazy var vp3Dot:CAShapeLayer = self.createDot(color:.blue)
   public override init() {
      super.init()
//      boxDot1.frame.origin = box1TowardsVP3
//      boxDot2.frame.origin = box2TowardsVP3
//      boxDot3.frame.origin = box3TowardsVP3
//      boxDot4.frame.origin = box4TowardsVP3
      
//      boxDot5.frame.origin = box5FromVP3
//      boxDot6.frame.origin = box6FromVP3
//      boxDot7.frame.origin = box7FromVP3
//      boxDot8.frame.origin = box8FromVP3
//      
   }
   /**
    * Boilerplate
    */
   required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
extension DebugCubeGraphic{
   /**
    *
    */
   public func debug(quad:Quad){
//      let quadCenter = CubeHelper.diagonalCenter(quadPoints: quad)
      let center:CGPoint = QuadUtil.center(quad: quad)
      
      let vp1 = CubeUtil.vp1(quad: quad,center:center)
      Swift.print("vp1:  \(vp1)")
      let vp2 = CubeUtil.vp2(quad: quad,center:center)
      Swift.print("vp2:  \(vp2)")
     
      let vp3 = CubeUtil.vp3(vp1: vp1, vp2: vp2, center: center/*,quad:quad*/)
      Swift.print("vp3:  \(vp3)")
      quadCenterDot.position = QuadUtil.diagonalCenter(quadPoints: quad)
      vp1Dot.position = vp1
      vp2Dot.position = vp2
      vp3Dot.position = vp3
//      let center = CubeHelper.center(quad: quad)
      _ = self.createLine(line: (vp1,center), color: .gray)
      _ = self.createLine(line: (vp2,center), color: .orange)
      _ = self.createLine(line: (vp1,vp3), color: .green)
      _ = self.createLine(line: (vp1,vp2), color: .purple)

      let orthoPoint:CGPoint = QuadUtil.orthoPoint(line: (vp1,vp2), point: center)//find point on vanishingpointline, ortho to diagonal center of quad

      orthPTDot.frame.origin = orthoPoint
//
//      let rayPT = vp1.add(CGPointParser.polar(100, Trig.angle(vp1, vp3)))
//      _ = self.createLine(line: (vp1,rayPT), color: .green)
      _ = self.createLine(line: (orthoPoint,center), color: .magenta)
      _ = self.createLine(line: (orthoPoint,vp3), color: .cyan)
   }
   func drawVPTriangle(){
      //      //Draw vp-triangle
      let vpTriangleShape:CAShapeLayer = .init()
      self.addSublayer(vpTriangleShape)
//      let vpPts:[CGPoint] = [vp1,vp2,vp3]
//      _ = CGShapeUtil.drawPolyLine(shapeLayer:vpTriangleShape, points:vpPts, style:(fillColor:nil,strokeColor:.blue,thickness:1), close:true)
   
   }
}
extension DebugCubeGraphic{
   /**
    * Dot
    */
   func createDot(color:Color) -> CAShapeLayer{
      let vp1Dot:CAShapeLayer = .init()
      _ = CGShapeUtil.drawCircle(with: vp1Dot, circle: (.zero,4), style: (color,.clear,0), progress: 1)
      self.addSublayer(vp1Dot)
      return vp1Dot
   }
   /**
    * Line
    */
   func createLine(line:Line,color:Color) -> CAShapeLayer{
      let shape:CAShapeLayer = .init()
      _ = CGShapeUtil.drawLine(lineLayer: shape, line: (line.p1,line.p2), style: (color,1))
      self.addSublayer(shape)
      return shape
   }
}
