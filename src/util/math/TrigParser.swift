import QuartzCore
import CoreGraphics

class TrigParser {
   /**
    * Returns a radian to be between 0 and Math.PI*2 Radian (0 - 6.28)
    * PARAM: theta: An radian in degrees typically 0 - Math.PI*2
    * NOTE: we use "while" function type here because angle could be very low at which point Math.PI*2 needs to be contrinuasly added until its above 0 )
    * TODO: ⚠️️ Use modulo like normalize2 does, is that faster ? do an optimization test.
    */
   static func normalize(_ angle:CGFloat)->CGFloat {
      var angle = angle
      while angle < 0 {angle += π*2}
      while angle >= π*2 {angle -= π*2}
      return angle
   }
   /**
    * Returns the span in a clockwise or counterclockwise direction (radian between 0 and Math.PI*2)
    * PARAM: direction is of the Direction.CLOCK_WISE or Direction.COUNTER_CLOCK_WISE type
    * PARAM: a (-Math.PI to Math.PI)
    * PARAM: b (-Math.PI to Math.PI)
    * NOTE: This method works great when finding angles in a triangle
    * NOTE: Using NumberParser.distance(a,b) to find an angle span doesnt work
    * NOTE: if you know that the anglespan is under π then you can also use: abs(Trig.difference(angle1, angle2))
    * EXAMPLE:
    * angleSpan(Math.PI*-0.5, Math.PI,Direction.COUNTER_CLOCK_WISE);//Math.PI*-0.5 to Math.PI = 4.71
    * angleSpan(Math.PI, Math.PI*0.5,Direction.COUNTER_CLOCK_WISE);//Math.PI to Math.PI*0.5 = 4.71
    * TODO: replace direction with boolean: isClockWise
    */
   static func angleSpan(_ a:CGFloat, _ b:CGFloat, _ direction:String = Trig.clockWise) -> CGFloat{
      if direction == Trig.clockWise {return Trig.normalize(b + (Trig.pi*2-a))}
      return Trig.normalize(a + (Trig.pi*2-b))/*Direction.COUNTER_CLOCK_WISE*/
   }
   /**
    * Returns an angle in radian between -3.14 and 3.14 (-180 and 180 converted to degress)
    * PARAM: a is the pivot point
    * PARAM: b is the polar point
    * NOTE: use this formula to find the angle in a (0,0) point-space Math.atan2(pointB.y, pointB.x)
    * NOTE: formula in standard form: Tan Ɵ = y/x (then use inverse tan to find the angle)
    */
   static func angle(_ a:CGPoint, _ b:CGPoint)->CGFloat {
      return atan2(b.y - a.y, b.x - a.x)
   }
   /**
    * Returns the difference between two angles, positive or negative
    * PARAM: startAngle (in radian)
    * PARAM: endAngle (in radian)
    */
   static func difference(_ startAngle:CGFloat,_ endAngle:CGFloat)->CGFloat {
      return atan2(sin(endAngle - startAngle), cos(endAngle - startAngle))
   }
   /**
    * Angle span
    */
   static func angleSpan3(pivot:CGPoint,a:CGPoint,b:CGPoint)->CGFloat{
      let angle1 = Trig.angle(pivot, a)
      Swift.print("angle1:  \(angle1)")
      let angle2 = Trig.angle(pivot, b)
      Swift.print("angle2:  \(angle2)")
      let A = abs(Trig.difference(angle1, angle2))
      return A
   }
}
