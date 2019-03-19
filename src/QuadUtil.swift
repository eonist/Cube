import QuartzCore
import CoreGraphics
/**
 * Helpers
 */
class QuadUtil{
   /**
    * convergingPoint
    */
   static func convergingPoint(a:Line,b:Line) -> CGPoint{
      let pointAndAngle:(p1:CGPoint,p2:CGPoint,a:CGFloat,b:CGFloat) = {
         let angleA:CGFloat = Trig.angle(a.p1, a.p2)
         let angleB:CGFloat = Trig.angle(b.p1, b.p2)
         let isConverging:Bool = CGPointAsserter.converging(a.p1, b.p1,angleA ,angleB )
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
      let vp1:CGPoint = QuadUtil.convergingPoint(a:diagonalA,b:diagonalB)//find convering point of horizontal lines
      return vp1
   }
   /**
    * center
    */
   static func center(quad:Quad) -> CGPoint{
      let x = CGPoint.midPt(quad.p1, quad.p2).x
      let y = CGPoint.midPt(quad.p1, quad.p3).y
      return .init(x:x,y:y)//let median = quadCenter//CGPoint.interpolate(horA.p2, horB.p2, 0.5)
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
