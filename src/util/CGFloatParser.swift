import Foundation
import QuartzCore
import CoreGraphics

extension CGFloat{
   func interpolate(_ to:CGFloat, _ scalar:CGFloat) -> CGFloat{return CGFloatParser.interpolate(self,to,scalar)}
}
class CGFloatParser{
   /**
    * Linearly interpolation (lerp)
    * PARAM: a: start number
    * PARAM: b: end number
    * PARAM: fraction: interpolation value (between 0 - 1) could also be named scalar
    * EXAMPLE: interpolate(5, 15, 0.5) //10
    * EXAMPLE: interpolate(a: -150.0, b: -375.0, fraction: 0.1)//-172.5, also works on negative values 👌
    */
   static func interpolate(_ a: CGFloat, _ b: CGFloat, _ fraction: CGFloat) -> CGFloat {
      return fraction * (b - a) + a
   }
}
