import QuartzCore
import CoreGraphics

extension CGPoint{
   static func polarPoint(_ radius:CGFloat, _ angle:CGFloat) -> CGPoint {/*Convenience*/
      return CGPointParser.polar(radius, angle)
   }
   static func distance(_ a:CGPoint, _ b:CGPoint) -> CGFloat{/*Convenience*/
      return CGPointParser.distance(a,b)
   }
   func add(_ p:CGPoint)->CGPoint{return CGPointParser.add(self, p)}
   func distance(_ p:CGPoint) -> CGFloat { return CGPoint.distance(self,p) }//distance from self to p
   static func interpolate(_ a:CGPoint, _ b:CGPoint, _ scalar:CGFloat) -> CGPoint{/*Convenience*/
      return CGPointParser.interpolate(a,b, scalar)
   }
}
