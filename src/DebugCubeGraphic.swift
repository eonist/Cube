import QuartzCore
import CoreGraphics

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
   lazy var vp1Dot:CAShapeLayer = self.createDot(color:.orange)
   lazy var vp2Dot:CAShapeLayer = self.createDot(color:.blue)
   lazy var quadCenterDot:CAShapeLayer = self.createDot(color:.yellow)
   lazy var orthPTDot:CAShapeLayer = self.createDot(color:.red)
   lazy var vp3Dot:CAShapeLayer = self.createDot(color:.purple)
   override init() {
      super.init()
//      vp1Dot.frame.origin = vp1
//      vp2Dot.frame.origin = vp2
//      quadCenterDot.frame.origin = quadCenter
//      _ = view.createLine(line: (vp1,quadCenter), color: .gray)
      //      _ = view.createLine(line: (vp2,quadCenter), color: .orange)
      
      
      //      _ = view.createLine(line: (vp1,vp2), color: .purple)
//      orthPTDot.frame.origin = orthoPoint
//      vp3Dot.frame.origin = vp3
//      let rayPT = vp1.add(CGPointParser.polar(300, VP1_VP3))
//      _ = self.createLine(line: (vp1,rayPT), color: .green)
//      _ = self.createLine(line: (orthoPoint,quadCenter), color: .magenta)
//      _ = self.createLine(line: (orthoPoint,vp3), color: .cyan)
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
//      _ = CGShapeUtil.drawCircle(with: vp1Dot, circle: (.zero,4), style: (color,.clear,0), progress: 1)
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
