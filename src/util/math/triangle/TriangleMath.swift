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
    * ortho point (Perpendicular on a line from a given point)
    */
   static func orthoPoint(p:CGPoint,line:(a:CGPoint,b:CGPoint)) -> CGPoint{
      let (x1,x2,x3,y1,y2,y3)  = (line.a.x,line.b.x,p.x,line.a.y,line.b.y,p.y)
      // first convert line to normalized unit vector
      var dx = x2 - x1;
      var dy = y2 - y1;
      let mag = sqrt(dx*dx + dy*dy)
      dx /= mag
      dy /= mag
      // translate the point and get the dot product
      let lambda = (dx * (x3 - x1)) + (dy * (y3 - y1))
      let x4 = (dx * lambda) + x1
      let y4 = (dy * lambda) + y1
      return .init(x:x4,y:y4)
   }
}
