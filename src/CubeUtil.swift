import QuartzCore
import CoreGraphics

public class CubeUtil{
   /**
    * Returns Cube for Quad
    * Abstract: imagine a perspective square in 3d space. Now draw a perfect cube around it with correct perspective
    */
   public static func cube(quad:Quad) -> Cube{
      let vp1 = CubeUtil.vp1(quad:quad)
      let vp2 = CubeUtil.vp2(quad: quad)
      let quadCenter:CGPoint = Util.diagonalCenter(quadPoints: quad)//find diagonal center of quadereliteral
      let ratio = CubeUtil.ratio(vp1: vp1, quad: quad, quadCenter: quadCenter)
      let vp3:CGPoint = vanishingPoint3(vp1: vp1, vp2: vp2, quadCenter: quadCenter)
      let cube = CubeUtil.cube(vp3: vp3, quad: quad, halfSideRatio: ratio.inward, increaseRatio: ratio.outward)
      return cube
   }
}
/**
 * vaneshing points
 */
extension CubeUtil{
   /**
    * vp1
    */
   static func vp1(quad:Quad)->CGPoint{
      let horA:Line = (quad.p1,quad.p2)//get horizontal point pair / line pair
      let horB:Line = (quad.p3,quad.p4)
      let vp1:CGPoint = Util.convergingPoint(a:horA,b:horB)//find convering point of horizontal lines
      return vp1
   }
   /**
    * vp2
    */
   static func vp2(quad:Quad)->CGPoint{
      let verA:Line = (quad.p1,quad.p3)//get vertical point pair / line pair
      let verB:Line = (quad.p2,quad.p4)
      let vp2:CGPoint = Util.convergingPoint(a:verA,b:verB)//find convering point of vertical lines
      return vp2
   }
   /**
    * vp3
    */
   static func vanishingPoint3(vp1:CGPoint,vp2:CGPoint,quadCenter:CGPoint) -> CGPoint{
      let span = abs(Trig.difference(Trig.angle(vp2, quadCenter), Trig.angle(quadCenter, vp1)))
      let VP1_QC_VP3:CGFloat = (CGFloat.pi / 2) - span
      let VP1_QC:CGFloat = Trig.angle(vp1, quadCenter)
      let VP1_VP3:CGFloat = Trig.normalize(VP1_QC+VP1_QC_VP3)
      let orthoPoint:CGPoint = Util.orthoPoint(line: (vp1,vp2), point: quadCenter)//find point on vanishingpointline, ortho to diagonal center of quad
      let ORTHO_PT_QUAD_PT:CGFloat = Trig.angle( orthoPoint, quadCenter)//find convering points of these two rays (this is vp3)
      let vp3:CGPoint = Util.convergingPoint(a: vp1, aAngle: VP1_VP3, b: orthoPoint, bAngle: ORTHO_PT_QUAD_PT)
      return vp3
   }
}
/**
 * Ratio calculation
 */
extension CubeUtil {
   /**
    * Returns ratio values to find the bound points of the cube
    * Abstract: use law of ratios to draw z-points of the cube.
    */
   static func ratio(vp1:CGPoint, quad:Quad, quadCenter:CGPoint ) -> (inward:CGFloat,outward:CGFloat){
      let halfSidePT:CGPoint = Util.convergingPoint(a: (vp1,quadCenter), b:(quad.p2,quad.p4))
      let vp1Length:CGFloat = CGPointParser.distance(quadCenter, vp1)
      let halfSideRatio:CGFloat = {//basically the ratio of how much half a square is in relation to the length of quad_center to vp1 (find ratio of half the length of the cube of quad_center_to_vp1)
         let halfSideDist:CGFloat = CGPointParser.distance(quadCenter,halfSidePT)
         return halfSideDist / vp1Length
      }()
      //find how much to multiply with to get 1/2 side outward from vp3
      let increaseRatio:CGFloat = {
         let dist_vp1_halfSidePT:CGFloat = CGPointParser.distance(halfSidePT, vp1)
         return vp1Length / dist_vp1_halfSidePT
      }()
      return (inward:halfSideRatio,outward:increaseRatio)
   }
}
/**
 * Law of ratios
 */
extension CubeUtil{
   /**
    * Return cube through use of law of ratios
    */
   static func cube(vp3:CGPoint,quad:Quad,halfSideRatio:CGFloat,increaseRatio:CGFloat) -> Cube{
      let back:Quad = self.back(vp3: vp3, quad: quad, halfSideRatio: halfSideRatio)
      let front:Quad = self.front(vp3: vp3, quad: quad, increaseRatio: increaseRatio)//do the same for the outward rect
      let cube:Cube = (front:front, back:back)//return the Cube as a tuple point container
      return cube
   }
   /**
    * back of cube
    * Abstract: interpolate from all points in quad to vp3
    */
   static func back(vp3:CGPoint,quad:Quad,halfSideRatio:CGFloat) -> Quad {
      let box1TowardsVP3:CGPoint = CGPoint.interpolate(quad.p1, vp3, halfSideRatio)
      let box2TowardsVP3:CGPoint = CGPoint.interpolate(quad.p2, vp3, halfSideRatio)
      let box3TowardsVP3:CGPoint = CGPoint.interpolate(quad.p3, vp3, halfSideRatio)
      let box4TowardsVP3:CGPoint = CGPoint.interpolate(quad.p4, vp3, halfSideRatio)
      return (box1TowardsVP3,box2TowardsVP3,box3TowardsVP3,box4TowardsVP3)
   }
   /**
    * Returns the front of the cube
    * Abstract: interpolate from vp3 to all points in quad
    */
   static func front(vp3:CGPoint,quad:Quad,increaseRatio:CGFloat) -> Quad {
      let box5FromVP3:CGPoint = CGPoint.interpolate(vp3,quad.p1, increaseRatio)
      let box6FromVP3:CGPoint = CGPoint.interpolate(vp3,quad.p2, increaseRatio)
      let box7FromVP3:CGPoint = CGPoint.interpolate(vp3,quad.p3, increaseRatio)
      let box8FromVP3:CGPoint = CGPoint.interpolate(vp3,quad.p4, increaseRatio)
      return (box5FromVP3,box6FromVP3,box7FromVP3,box8FromVP3)
   }
}
/**
 * Helpers
 */
private  class Util{
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
      let vp1:CGPoint = Util.convergingPoint(a:diagonalA,b:diagonalB)//find convering point of horizontal lines
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
