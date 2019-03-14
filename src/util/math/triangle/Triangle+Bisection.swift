import UIKit

extension TriangleMath {
   /**
    * Returns a point that 2 points and 2 directions converge at (think the third point in an triangle if you have 2 points and the angles)
    * PARAM: p1 is the equvilant to point A
    * PARAM: p2 is the equvilant to point B
    * PARAM: angleA is the angle from p1 to p3 (p3 == point C) "the outAngle of a point on a line"
    * PARAM: angleB is the angle from p2 to p3 "the outAngle of a point on a line"
    * NOTE: the distance from p1 to p2 is the side c in a the triangle
    * TODO: ⚠️️ move to Trig.as or pointparser.as
    * TODO: ⚠️️ could we use more Vector math like formulas here? by using slopes etc
    * TODO: ⚠️️ what happens if the vectors ar parallel?, i guess you need to assert if they are not parallel first, but what about diverging?
    */
   static func convergingPoint(p1:CGPoint,p2:CGPoint,angleA:CGFloat,angleB:CGFloat) -> CGPoint {
      let A:CGFloat = Trig.angleSpan(Trig.angle(p1, p2), angleA)
      //Swift.print("A: " + A)
      let B:CGFloat = Trig.angleSpan(angleB,Trig.angle(p2, p1))
      //Swift.print("B: " + B)
      let C:CGFloat = π - B - A/*Angle C*/
      let c:CGFloat = CGPoint.distance(p1, p2)/*The length of side c*/
      if A < B {
         return p1.add(CGPoint.polarPoint(cBCTob2(c, B, C), angleA))
      }/*p3*/
      else {
         return p2.add(CGPoint.polarPoint(cACToa2(c, A, C), angleB))
      }/*p3, a is The length of side a*/
   }
}
