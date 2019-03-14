
import UIKit

class CGPointParser{
   /**
    * Returns the distance between two points
    * NOTE: Math formula for distance of two points is: AB2 = dx2 + dy2 (distance = sqrt(dx2 + dy2)) where one side is dx - the difference in x-coordinates, and the other is dy - the difference in y-coordinates.
    * NOTE: Math formula: c^2=a^2+b^2 (||u|| = √h^2+v^2) (in triangle notation c= hypotenus etc)
    */
   static func distance(_ a:CGPoint,_ b:CGPoint) -> CGFloat{
      let xDifference:CGFloat = b.x - a.x
      let yDifference:CGFloat = b.y - a.y
      return sqrt(pow(xDifference, 2) + pow(yDifference, 2))
   }
   /**
    * Returns a point, in a polar cordinate system (from 0,0), for PARAM: angle and PARAM: length
    * Return: a point on a circle where the pivot is TopLeft Corner (0,0)
    * PARAM: radius: the radius of the circle
    * PARAM: angle: the angle where the point is (in radians) (-π to π) (3.14.. to 3.14..)
    * NOTE: formula "<angle*cos*radius,angle*sin*radius>"
    * NOTE: One can also use Point.polar(radius,radian) or equivilent method in the spesific language
    * Base formula CosΘ = x/len
    * Base Formula SinΘ = y/len
    * EXAMPLE: CGPoint.polarPoint(100, π/4)//polarPoint:  (70.7106781186548, 70.7106781186547) bottomRight corner
    * NOTE: π = Double.pi
    */
   static func polar(_ radius:CGFloat, _ angle:CGFloat) -> CGPoint {
      let x:CGFloat = /*radius + */(radius * cos(angle))
      let y:CGFloat = /*radius + */(radius * sin(angle))
      return CGPoint(x:x, y:y)
   }
   /**
    * Returns a new point comprised of the addition of two points
    */
   static func add(_ a:CGPoint,_ b:CGPoint) -> CGPoint {
      return CGPoint(x:a.x+b.x, y:a.y+b.y)
   }
}
