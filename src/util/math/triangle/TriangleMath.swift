import QuartzCore
import CoreGraphics

class TriangleMath{
   /**
    * NOTE: Distance from a point to a line
    * NOTE: also called "perpendicular distance"
    */
   static func orthogonalDist(p:CGPoint, p1:CGPoint,p2:CGPoint)->CGFloat{
      let angle1 = Trig.angle(p2, p)
      let angle2 = Trig.angle(p2, p1)
      let c = p2.distance(p)
      let A = abs(Trig.difference(angle1, angle2))
      let a:CGFloat = TriangleMath.cACToa2(c, A, π/2)
      return a
   }
   /**
    * TODO: This can be written better. you could rotate the world, you could use slope, you could use: aABTob or cBCTob or cBCTob2
    */
   static func orthoPoint(p:CGPoint,line:(a:CGPoint,b:CGPoint)) -> CGPoint{
      let orthoDist:CGFloat = TriangleMath.orthogonalDist(p: p, p1: line.a, p2: line.b)
      let span:CGFloat = abs(Trig.difference(Trig.angle(line.a, line.b), Trig.angle(line.a, p)))
      let angle:CGFloat = π - (π/2) - span
      let angleToOrthoPoint:CGFloat = Trig.normalize(Trig.angle(p, line.a) + angle)
      let polarPt:CGPoint = CGPoint.polarPoint(orthoDist, angleToOrthoPoint)
      return p.add(polarPt)
   }
}
