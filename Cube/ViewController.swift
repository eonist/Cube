import UIKit
import Cube_iOS

class ViewController: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let closure:(_ pts:[CGPoint],_ yOffset:CGFloat) -> Void = { pts,yOffset in
         let pts:[CGPoint] = pts.map{  .init(x:$0.x,y:$0.y+yOffset)  }
         let polyShape:CAShapeLayer = .init()//draw polyshape based on 4 points
         self.view.layer.addSublayer(polyShape)
         _ = CGShapeUtil.drawPolyLine(shapeLayer:polyShape, points:pts, style:(fillColor:nil,strokeColor:.orange,thickness:1), close:true)
         let quad:Quad = (pts[0],pts[1],pts[3],pts[2])// Note order: top left, top right, bottom left, bottom right
         let cube:Cube = CubeUtil.cube(quad:quad)
         let cubeGraphic:CubeGraphic = .init()// DebugCubeGraphic
         self.view.layer.addSublayer(cubeGraphic)
         cubeGraphic.drawCube(cube: cube)
//         cubeGraphic.debug(quad:quad)
      }
      
      /*verCol*/
      let pts:[CGPoint] = [.init(x:140,y:130),.init(x:210,y:160),.init(x:210,y:190),.init(x:140,y:220)]
      closure(pts,0)
      /*horCol*/
      let pts2:[CGPoint] = [.init(x:140,y:130),.init(x:210,y:130),.init(x:240,y:220),.init(x:110,y:220)]
      closure(pts2,160)
      /*3p*/
      let pts3:[CGPoint] = [.init(x:100,y:130),.init(x:220,y:150),.init(x:200,y:220),.init(x:130,y:240)]
      closure(pts3,320)
   }
}
