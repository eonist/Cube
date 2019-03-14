
import UIKit

class CGPointAsserter{
   /**
    * NOTE: Converging is when a trajectory hits the the infinite head of the other point
    * NOTE: converging is when the head of each trajectory converge
    * TODO: write the math formula for this method and explaine more verbosly
    */
   static func converging(_ p1:CGPoint,_ p2:CGPoint,_ angle1:CGFloat,_ angle2:CGFloat) -> Bool {
      let p1A:CGPoint = CGPoint.polarPoint(100, angle1).add(p1)
      let p1B:CGPoint = CGPoint.polarPoint(100, angle1-π).add(p1)
      let p2A:CGPoint = CGPoint.polarPoint(100, angle2).add(p2)
      let p2B:CGPoint = CGPoint.polarPoint(100, angle2-π).add(p2)
      let len:CGFloat = CGPoint.distance(p1A, p2A)
      return len < CGPoint.distance(p1B, p2A) && len < CGPoint.distance(p2A, p2B)
   }
   /**
    * NOTE: doing !convering is not the same as the bellow, because !convering could mean isParallel
    * TODO: diverging is when the tail of both trajectories converge, then shouldnt it be possible to test for the converging of said tails with the converging method, it should
    * TODO: oppositeDirection is when a trajectory hits the infinite tail of the other point,hmm im not so sure
    * TODO: collinearNormal is when both trajectories point onto each other
    * TODO: you need a term when 2 vectors are collinear but point in opposite direction, contraDirectional is the Antonym of coDirectional which is when 2 lines are paralell and pointing in the same direction
    */
   static func diverging(_ p1:CGPoint,_ p2:CGPoint,_ angle1:CGFloat,_ angle2:CGFloat) -> Bool {
      let p1A:CGPoint = CGPoint.polarPoint(100, angle1).add(p1)
      let p1B:CGPoint = CGPoint.polarPoint(100, angle1-π).add(p1)
      let p2A:CGPoint = CGPoint.polarPoint(100, angle2).add(p2)
      let p2B:CGPoint = CGPoint.polarPoint(100, angle2-π).add(p2)
      let len:CGFloat = CGPoint.distance(p1A, p2A)
      return len > CGPoint.distance(p1B, p2A) && len > CGPoint.distance(p2A, p2B)
   }
}
