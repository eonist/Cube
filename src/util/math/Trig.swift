import Foundation

let π = CGFloat(Double.pi)/*Global variable*/
let π2 = CGFloat(Double.pi/2)/*Global variable,pi/2*/
let π4 = CGFloat(Double.pi/4)/*Global variable,pi/4*/
let ㎭ = π/180/*Global variable*/
class Trig{
   static let clockWise:String = "clockWise"
   static let cw:String = Trig.clockWise
   static let counterClockWise:String = "counterClockWise"
   static let pi:CGFloat = π// pi (3.14)
}

extension Trig{
   static func normalize(_ angle:CGFloat)->CGFloat {return TrigParser.normalize(angle)}
   static func angle(_ a:CGPoint, _ b:CGPoint)->CGFloat {return TrigParser.angle(a, b)}
   static func angleSpan(_ a:CGFloat, _ b:CGFloat, _ direction:String = Trig.clockWise) -> CGFloat{return TrigParser.angleSpan(a, b, direction)}
   static func difference(_ startAngle:CGFloat,_ endAngle:CGFloat)->CGFloat {return TrigParser.difference(startAngle, endAngle)}
}

class TrigAsserter{
   /**
    * new
    */
   static func isCoDir(_ a:CGFloat,_ b:CGFloat) -> Bool {
      let normalizedA:CGFloat = Trig.normalize(a)
      let normalizedB:CGFloat = Trig.normalize(b)
      return normalizedA == normalizedB
   }
}
