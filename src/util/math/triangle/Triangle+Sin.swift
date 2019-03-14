import UIKit

extension TriangleMath{
   /**
    * Returns the Side a of an triangle
    * Based on formula: a/SinA = c/SinC
    * NOTE: uses radian instead of degree
    * NOTE i think this also works on non-right-angle-triangles
    */
   static func cACToa2(_ c:CGFloat,_ A:CGFloat,_ C:CGFloat) -> CGFloat { // TODO: move to trianglemath2
      return sin(A) * (c / sin(C))
   }
   /**
    * Returns the Side b of an triangle
    * NOTE: Based on formula: b/SinB = c/SinC
    */
   static func cBCTob2(_ c:CGFloat,_ B:CGFloat,_ C:CGFloat) -> CGFloat {//TODO: move to trianglemath2
      return sin(B) * (c / sin(C))
   }
}
