import QuartzCore
import CoreGraphics

// note order: top left, top right, bottom left, bottom right
public typealias Quad = (p1:CGPoint,p2:CGPoint,p3:CGPoint,p4:CGPoint)
public typealias Cube = (front:Quad,back:Quad)
//type
public typealias Line = (p1:CGPoint,p2:CGPoint)

