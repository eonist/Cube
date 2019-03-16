import UIKit
import Cube_iOS

class ViewController: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let polyShape:CAShapeLayer = .init()//draw polyshape based on 4 points
      view.layer.addSublayer(polyShape)
//      /*3p*/let pts:[CGPoint] = [.init(x:100,y:130),.init(x:220,y:150),.init(x:200,y:220),.init(x:130,y:240)]
//      /*horCol*/let pts:[CGPoint] = [.init(x:140,y:130),.init(x:210,y:130),.init(x:240,y:220),.init(x:110,y:220)]
      /*verCol*/let pts:[CGPoint] = [.init(x:140,y:130),.init(x:210,y:160),.init(x:210,y:190),.init(x:140,y:220)]
      let corners:[CGPoint] = pts
      _ = CGShapeUtil.drawPolyLine(shapeLayer:polyShape, points:corners, style:(fillColor:nil,strokeColor:.orange,thickness:1), close:true)
      
      let quad:Quad = (corners[0],corners[1],corners[3],corners[2])// Note order: top left, top right, bottom left, bottom right
      let cube:Cube = CubeUtil.cube(quad:quad)
      let cubeGraphic:DebugCubeGraphic = .init()//DebugCubeGraphic
      view.layer.addSublayer(cubeGraphic)
      cubeGraphic.drawCube(cube: cube)
      cubeGraphic.debug(quad:quad)
   }
}
