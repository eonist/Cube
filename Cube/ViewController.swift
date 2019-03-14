import UIKit

// TODO: add draw cirle, and draw line tools

class ViewController: UIViewController {
   //debug
   lazy var vp1Dot:CAShapeLayer = createDot(color:.orange)
   lazy var vp2Dot:CAShapeLayer = createDot(color:.blue)
   lazy var quadCenterDot:CAShapeLayer = createDot(color:.yellow)
   lazy var orthPTDot:CAShapeLayer = createDot(color:.red)
   lazy var vp3Dot:CAShapeLayer = createDot(color:.purple)
   //type
   typealias Line = (p1:CGPoint,p2:CGPoint)
   typealias Quad = (p1:CGPoint,p2:CGPoint,p3:CGPoint,p4:CGPoint)
   override func viewDidLoad() {
      super.viewDidLoad()
      //draw polyshape based on 4 points
      
      let polyShape:CAShapeLayer = .init()
      view.layer.addSublayer(polyShape)
      let corners:[CGPoint] = [.init(x:100,y:130),.init(x:220,y:150),.init(x:200,y:220),.init(x:130,y:240)]
      _ = CGShapeUtil.drawPolyLine(shapeLayer:polyShape, points:corners, style:(fillColor:nil,strokeColor:.black,thickness:1), close:true)

      //get horizontal point pair / line pair
      let horA:Line = (corners[0],corners[1])
      let horB:Line = (corners[3],corners[2])
      //get vertical point pair / line pair
      let verA:Line = (corners[0],corners[3])
      let verB:Line = (corners[1],corners[2])
      
      //find convering point of horizontal lines
      let vp1:CGPoint = Util.convergingPoint(a:horA,b:horB)
//      Swift.print("vp1:  \(vp1)")
      vp1Dot.frame.origin = vp1
      
      
//      //find convering point of vertical lines
      let vp2:CGPoint = Util.convergingPoint(a:verA,b:verB)
      vp2Dot.frame.origin = vp2
//
//      //find diagonal center of quadereliteral
//      // note order: top left, top right, bottom left, bottom right
      let quad:Quad = (corners[0],corners[1],corners[3],corners[2])
      let quadCenter:CGPoint = Util.diagonalCenter(quadPoints: quad)
      quadCenterDot.frame.origin = quadCenter
      _ = createLine(line: (vp1,quadCenter), color: .gray)
      _ = createLine(line: (vp2,quadCenter), color: .orange)
      
//      //find line of 2 vanishing points
//      Swift.print("vp1:  \(vp1)")
//      Swift.print("vp2:  \(vp2)")
      _ = createLine(line: (vp1,vp2), color: .purple)
      
//      //find angel of ray from vp1 to vp3 (use vp2 ray and vp1 ray and substract 180)
      let QC_VP1_VP2:CGFloat = Trigo.angle(pivot:quadCenter,a:vp1,b:vp2)
      Swift.print("QC_VP1_VP2:  \(QC_VP1_VP2)")
      Swift.print("CGFloat.pi:  \(CGFloat.pi)")
//      let ORTHO_VP1:CGFloat = QC_VP1_VP2 - (CGFloat.pi / 4)
//      Swift.print("ORTHO_VP1:  \(ORTHO_VP1)")
      let span = abs(Trig.difference(Trig.angle(vp2, quadCenter), Trig.angle(quadCenter, vp1)))
      Swift.print("span:  \(span)")
      let VP1_QC_VP3:CGFloat = (CGFloat.pi / 2) - span
      Swift.print(":  \(VP1_QC_VP3)")
      let VP1_QC:CGFloat = Trigo.angle(a: vp1, b: quadCenter)
      Swift.print("VP1_QC:  \(VP1_QC)")
      let VP1_VP3:CGFloat = Trigo.normalize(angle:VP1_QC+VP1_QC_VP3)
      Swift.print("VP1_VP3:  \(VP1_VP3)")
      let rayPT = vp1.add(CGPointParser.polar(300, VP1_VP3))
      Swift.print("rayPT:  \(rayPT)")
      _ = createLine(line: (vp1,rayPT), color: .green)
////
////      //find angel of ray from vp2 to vp3 🚫
////
////      //find point on vanishingpointline, ortho to diagonal center of quad
      let orthoPoint:CGPoint = Util.orthoPoint(line: (vp1,vp2), point: quadCenter)
      orthPTDot.frame.origin = orthoPoint
      _ = createLine(line: (orthoPoint,quadCenter), color: .magenta)
//
////      //find convering points of these two rays (this is vp3)
      let ORTHO_PT_QUAD_PT:CGFloat = Trigo.angle(a: orthoPoint, b: quadCenter)
      Swift.print("ORTHO_PT_QUAD_PT:  \(ORTHO_PT_QUAD_PT)")
      let vp3:CGPoint = Util.convergingPoint(a: vp1, aAngle: VP1_VP3, b: orthoPoint, bAngle: ORTHO_PT_QUAD_PT)
      Swift.print("vp3:  \(vp3)")

      vp3Dot.frame.origin = vp3
      _ = createLine(line: (orthoPoint,vp3), color: .cyan)
      
//
//      //Draw vp-triangle
//      let vpTriangleShape:CAShapeLayer = .init()
//      view.layer.addSublayer(vpTriangleShape)
//      let vpPts:[CGPoint] = [vp1,vp2,vp3]
//      _ = CGShapeUtil.drawPolyLine(shapeLayer:vpTriangleShape, points:vpPts, style:(fillColor:nil,strokeColor:.blue,thickness:1), close:true)
      
      //use law of ratios to draw z-points of the cube.
      
      //connect the z points to complete the cube
   }
}
extension ViewController{
   class Util{
      /**
       * convergingPoint
       */
      static func convergingPoint(a:Line,b:Line) -> CGPoint{
         let pointAndAngle:(p1:CGPoint,p2:CGPoint,a:CGFloat,b:CGFloat) = {
            let angleA:CGFloat = Trig.angle(a.p1, a.p2)
//            Swift.print("angleA:  \(angleA)")
            let angleB:CGFloat = Trig.angle(b.p1, b.p2)
//            Swift.print("angleB:  \(angleB)")
            let isConverging:Bool = CGPointAsserter.converging(a.p1, b.p1,angleA ,angleB )
//            Swift.print("isConverging:  \(isConverging)")
            if isConverging {
               return (a.p1,b.p1,angleA,angleB)
            }else {
               return (a.p2,b.p2,Trig.angle(a.p1, a.p2),Trig.angle(b.p1, b.p2))
            }
         }()
         
         return TriangleMath.convergingPoint(p1: pointAndAngle.p1, p2: pointAndAngle.p2, angleA: pointAndAngle.a, angleB: pointAndAngle.b)
      }
      /**
       * diagonalCenter
       */
      static func diagonalCenter(quadPoints:Quad) -> CGPoint{
         let diagonalA:Line = (quadPoints.p1,quadPoints.p4)
         let diagonalB:Line = (quadPoints.p2,quadPoints.p3)
         //find convering point of horizontal lines
         let vp1:CGPoint = Util.convergingPoint(a:diagonalA,b:diagonalB)
         return vp1
      }
      /**
       * converingPoint (Ray
       */
      static func convergingPoint(a:CGPoint,aAngle:CGFloat,b:CGPoint,bAngle:CGFloat) -> CGPoint {
         return TriangleMath.convergingPoint(p1: a, p2: b, angleA: aAngle, angleB: bAngle)
      }
      /**
       * orthoPoint
       */
      static func orthoPoint(line:Line,point:CGPoint) -> CGPoint{
         return TriangleMath.orthoPoint(p: point, line: (line.p1,line.p2))
      }
   }
}

private class Trigo{
   /**
    *
    */
   static func angle(pivot:CGPoint,a:CGPoint,b:CGPoint)->CGFloat{
      let angle1 = Trig.angle(pivot, a)
      let angle2 = Trig.angle(pivot, b)
      let A = abs(Trig.difference(angle1, angle2))
      return A
   }
   static func angle(a:CGPoint,b:CGPoint)->CGFloat{
      return Trig.angle(a, b)
   }
   static func normalize(angle:CGFloat) -> CGFloat{
      return Trig.normalize(angle)
   }
}

extension ViewController{
   /**
    *
    */
   func createDot(color:UIColor) -> CAShapeLayer{
      let vp1Dot:CAShapeLayer = .init()
      _ = CGShapeUtil.drawCircle(with: vp1Dot, circle: (.zero,4), style: (color,.clear,0), progress: 1)
      view.layer.addSublayer(vp1Dot)
      return vp1Dot
   }
   func createLine(line:Line,color:UIColor) -> CAShapeLayer{
      let shape:CAShapeLayer = .init()
      _ = CGShapeUtil.drawLine(lineLayer: shape, line: (line.p1,line.p2), style: (color,1))
      view.layer.addSublayer(shape)
      return shape
   }
}
