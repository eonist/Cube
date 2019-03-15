import UIKit
import Cube_iOS

class ViewController: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let polyShape:CAShapeLayer = .init()//draw polyshape based on 4 points
      view.layer.addSublayer(polyShape)
      let corners:[CGPoint] = [.init(x:100,y:130),.init(x:220,y:150),.init(x:200,y:220),.init(x:130,y:240)]
      _ = CGShapeUtil.drawPolyLine(shapeLayer:polyShape, points:corners, style:(fillColor:nil,strokeColor:.orange,thickness:1), close:true)
      
      let quad:Quad = (corners[0],corners[1],corners[3],corners[2])// note order: top left, top right, bottom left, bottom right
      let cube:Cube = CubeUtil.cube(quad:quad)
      let cubeGraphic:CubeGraphic = .init()//DebugCubeGraphic
      view.layer.addSublayer(cubeGraphic)
      cubeGraphic.drawCube(cube: cube)
   }
}
