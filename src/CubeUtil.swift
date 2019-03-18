import QuartzCore
import CoreGraphics

public class CubeUtil{
   /**
    * Returns Cube for Quad
    * Abstract: imagine a perspective square in 3d space. Now draw a perfect cube around it with correct perspective
    */
   public static func cube(quad:Quad) -> Cube{
      let center:CGPoint = CubeHelper.center(quad: quad)
      let vp1 = CubeUtil.vp1(quad:quad, center:center )
      let vp2 = CubeUtil.vp2(quad: quad, center:center )
      let ratio = CubeUtil.ratio(vp1: vp1, vp2:vp2, quad: quad, center:center)
      let vp3:CGPoint = CubeUtil.vp3(vp1: vp1, vp2: vp2 ,center:center/*,quad:quad*/)
      let cube = CubeUtil.cube(vp3: vp3, quad: quad, halfSideRatio: ratio.inward, increaseRatio: ratio.outward)
      return cube
   }
}
/**
 * Vanishing points
 */
extension CubeUtil{
   /**
    * vp1
    */
   static func vp1(quad:Quad,center:CGPoint)->CGPoint{
      let horA:Line = (quad.p1,quad.p2)//get horizontal point pair / line pair
      let horB:Line = (quad.p3,quad.p4)
      let isCoDir = CGPointAsserter.isCoDirectional(horA.p1, horA.p2, horB.p1, horB.p2)
      Swift.print("isCoDir:  \(isCoDir)")
      if isCoDir {
         let median:CGPoint = CubeHelper.center(quad: quad)//.init(x:CGPoint.interpolate(quad.p1, quad.p2, 0.5).x,y:CGPoint.interpolate(quad.p1, quad.p3, 0.5).y)//let median = quadCenter//CGPoint.interpolate(horA.p2, horB.p2, 0.5)
         let angle = Trig.angle(horA.p1, horA.p2)
         let polarPT = CGPoint.polarPoint(CGFloat(UInt16.max), angle)
         let vp1 = median.add(polarPT)
         return vp1
      }else {
         let vp1:CGPoint = CubeHelper.convergingPoint(a:horA,b:horB)//find converging point of horizontal lines
         return vp1
      }
   }
   /**
    * vp2
    */
   static func vp2(quad:Quad,center:CGPoint)->CGPoint{
      let verA:Line = (quad.p1,quad.p3)//get vertical point pair / line pair
      let verB:Line = (quad.p2,quad.p4)
      let vp2:CGPoint = CubeHelper.convergingPoint(a:verA,b:verB)//find convering point of vertical lines
      if vp2.x.isInfinite && vp2.y.isInfinite {
         let median:CGPoint = CubeHelper.center(quad: quad)
         let angle = Trig.angle(verA.p1, verA.p2)
         let polarPT = CGPoint.polarPoint(CGFloat(UInt16.max), angle)
         return median.add(polarPT)
      }
      return vp2
   }
   /**
    * vp3
    */
   static func vp3(vp1:CGPoint,vp2:CGPoint,center:CGPoint/*,quad:Quad*/) -> CGPoint{
//      let center = CubeHelper.center(quad: quad)
      let span = abs(Trig.difference(Trig.angle(vp2, center), Trig.angle(center, vp1)))
      let VP1_QC_VP3:CGFloat = (CGFloat.pi / 2) - span
      let VP1_QC:CGFloat = Trig.angle(vp1, center)
      let VP1_VP3:CGFloat = Trig.normalize(VP1_QC+VP1_QC_VP3)
      let orthoPoint:CGPoint = CubeHelper.orthoPoint(line: (vp1,vp2), point: center)//find point on vanishingpointline, ortho to diagonal center of quad
      let ORTHO_PT_QUAD_PT:CGFloat = Trig.angle( orthoPoint, center)//find converging points of these two rays (this is vp3)
      let vp3:CGPoint = CubeHelper.convergingPoint(a: vp1, aAngle: VP1_VP3, b: orthoPoint, bAngle: ORTHO_PT_QUAD_PT)
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
    * - TODO: ⚠️️ THIS NEEDS BETTER CODE ⚠️️, you have to figure out which 2 points are closer to vp, but less complicated than this
    */
   static func ratio(vp1:CGPoint, vp2:CGPoint,quad:Quad, center:CGPoint/*, quadCenter:CGPoint*/ ) -> (inward:CGFloat,outward:CGFloat){
      
//      Swift.print("center:  \(center)")
      let vp1Dist = CGPoint.distance(vp1,center)
//      Swift.print("vp1Dist:  \(vp1Dist)")
      let vp2Dist = CGPoint.distance(vp2,center)
//      Swift.print("vp2Dist:  \(vp2Dist)")
      let closestVP:CGPoint = vp1Dist <= vp2Dist ? vp1 : vp2
//      Swift.print("closestVP:  \(closestVP)")
      let side:(CGPoint,CGPoint) = {
         if vp1Dist <= vp2Dist {
            let ver1Center:CGPoint = CGPoint.midPt(quad.p1, quad.p3 )
            let ver2Center:CGPoint = CGPoint.midPt(quad.p2, quad.p4 )
            let ver1CenterDist:CGFloat = CGPoint.distance(ver1Center, vp1)
            let ver2CenterDist:CGFloat = CGPoint.distance(ver2Center, vp1)
            return ver1CenterDist <= ver2CenterDist ?  (quad.p1, quad.p3) : (quad.p2, quad.p4)
         }else {
            let hor1Center:CGPoint = CGPoint.midPt(quad.p1, quad.p2 )
            let hor2Center:CGPoint = CGPoint.midPt(quad.p3, quad.p4 )
            let hor1CenterDist:CGFloat = CGPoint.distance(hor1Center, vp2)
            let hor2CenterDist:CGFloat = CGPoint.distance(hor2Center, vp2)
            return hor1CenterDist <= hor2CenterDist ?  (quad.p1, quad.p2) : (quad.p3, quad.p4)
         }
      }()
//      Swift.print("side:  \(side)")
      let diagonalCenter:CGPoint = CubeHelper.diagonalCenter(quadPoints: quad)//find diagonal center of quadereliteral
      let halfSidePT:CGPoint = CubeHelper.convergingPoint(a: (closestVP,diagonalCenter), b:side)
//      Swift.print("halfSidePT:  \(halfSidePT)")
      let vpLength:CGFloat = CGPointParser.distance(diagonalCenter, closestVP)
//      Swift.print("vp1Length:  \(vpLength)")
      let halfSideRatio:CGFloat = {//basically the ratio of how much half a square is in relation to the length of quad_center to vp1 (find ratio of half the length of the cube of quad_center_to_vp1)
         let halfSideDist:CGFloat = CGPointParser.distance(diagonalCenter,halfSidePT)
         return halfSideDist / vpLength
      }()
//      Swift.print("halfSideRatio:  \(halfSideRatio)")
      //find how much to multiply with to get 1/2 side outward from vp3
      let increaseRatio:CGFloat = {
         let dist_vp1_halfSidePT:CGFloat = CGPointParser.distance(halfSidePT, closestVP)
         return vpLength / dist_vp1_halfSidePT
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
class CubeHelper{
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
      let vp1:CGPoint = CubeHelper.convergingPoint(a:diagonalA,b:diagonalB)//find convering point of horizontal lines
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
