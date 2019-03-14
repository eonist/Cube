

import UIKit

class ViewController: UIViewController {
   typealias Line = (p1:CGPoint,p2:CGPoint)
   typealias Quad = (p1:CGPoint,p2:CGPoint,p3:CGPoint,p4:CGPoint)
   override func viewDidLoad() {
      super.viewDidLoad()
     
      
      //draw polyshape based on 4 points
      
      let polyShape:CAShapeLayer = .init()
      view.layer.addSublayer(polyShape)
      let corners:[CGPoint] = [.init(x:100,y:130),.init(x:230,y:140),.init(x:200,y:220),.init(x:130,y:230)]
      _ = CGShapeUtil.drawPolyLine(shapeLayer:polyShape, points:corners, style:(fillColor:nil,strokeColor:.black,thickness:1), close:true)

      
      //get horizontal point pair / line pair
      let horA:Line = (corners[0],corners[1])
      let horB:Line = (corners[3],corners[2])
      //get vertical point pair / line pair
      let verA:Line = (corners[0],corners[3])
      let verB:Line = (corners[1],corners[2])
      
      //find convering point of horizontal lines
      let vp1:CGPoint = Util.convergingPoint(a:horA,b:horB)
      //find convering point of vertical lines
      let vp2:CGPoint = Util.convergingPoint(a:verA,b:verB)
      
      
      //find diagonal center of quadereliteral
      // note order: top left, top right, bottom left, bottom right
      let quad:Quad = (corners[0],corners[1],corners[3],corners[2])
      let quadCenter:CGPoint = Util.diagonalCenter(quadPoints: quad)
      //find line of 2 vanishing points
      
      
      
      //find angel of ray from vp1 to vp3 (use vp2 ray and vp1 ray and substract 180)
      let QC_VP1_VP2:CGFloat = Trigo.angle(pivot:quadCenter,a:vp1,b:vp2)
      let ORTHO_VP1:CGFloat = QC_VP1_VP2 - (CGFloat.pi / 4)
      let VP1_QC_VP3:CGFloat = (CGFloat.pi / 4) - ORTHO_VP1
      let VP1_QC:CGFloat = Trigo.angle(a: vp1, b: quadCenter)
      let VP1_VP3:CGFloat = Trigo.normalize(angle:VP1_QC_VP3+VP1_QC)
     
      //find angel of ray from vp2 to vp3 🚫
      
      //find point on vanishingpointline, ortho to diagonal center of quad
      let orthoPoint:CGPoint = Util.orthoPoint(line: (vp1,vp2), point: quadCenter)
      
      //find convering points of these two rays (this is vp3)
      let ORTHO_PT_QUAD_PT:CGFloat = Trigo.angle(a: orthoPoint, b: quadCenter)
      let vp3:CGPoint = Util.convergingPoint(a: vp1, aAngle: VP1_VP3, b: orthoPoint, bAngle: ORTHO_PT_QUAD_PT)
      
      //Draw vp-triangle
      let vpTriangleShape:CAShapeLayer = .init()
      view.layer.addSublayer(vpTriangleShape)
      let vpPts:[CGPoint] = [vp1,vp2,vp3]
      _ = CGShapeUtil.drawPolyLine(shapeLayer:vpTriangleShape, points:vpPts, style:(fillColor:nil,strokeColor:.blue,thickness:1), close:true)
      
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
            let angleB:CGFloat = Trig.angle(a.p1, a.p2)
            let isConverging:Bool = CGPointAsserter.converging(a.p1, b.p1,angleA ,angleB )
            if isConverging {
               return (a.p1,b.p1,angleA,angleB)
            }else {
               return (a.p2,b.p2,Trig.angle(a.p1, a.p2),Trig.angle(a.p1, a.p2))
            }
         }()
         
         return TriangleMath.convergingPoint(p1: pointAndAngle.p1, p2: pointAndAngle.p2, angleA: pointAndAngle.a, angleB: pointAndAngle.b)
      }
      /**
       * diagonalCenter
       */
      static func diagonalCenter(quadPoints:Quad) -> CGPoint{
         return .zero
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
