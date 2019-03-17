![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg) ![platform](https://img.shields.io/badge/Platform-iOS-blue.svg) ![platform](https://img.shields.io/badge/Platform-macOS-blue.svg) ![Lang](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![codebeat badge](https://codebeat.co/badges/75878ed6-7cda-47d5-9f8d-67c1dd43ab6e)](https://codebeat.co/projects/github-com-eonist-cube-master)

# Cube

<img width="503" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-03-15 at 22.05.04.png?raw=true">

### What is it
Convert perspective square to perspective cube

### How does it work
- Finds perspective vanishing points
- Uses law of ratios to find correct volume
- Returns 2d-Points of the cube bounds

### How do I get it
- Carthage `github "eonist/Cube"`
- Manual Open `Cube.xcodeproj`
- CocoaPod (Coming soon)

### Example:
```swift
let corners:[CGPoint] = [.init(x:100,y:130),.init(x:220,y:150),.init(x:200,y:220),.init(x:130,y:240)]
let quad:Quad = (corners[0],corners[1],corners[3],corners[2])
let cube:Cube = CubeUtil.cube(quad:quad)
let cubeGraphic:CubeGraphic = .init()
layer.addSublayer(cubeGraphic)
cubeGraphic.drawCube(cube: cube)
```
### References:
- Mapping images to Quadrilaterals [https://github.com/paulz/PerspectiveTransform](https://github.com/paulz/PerspectiveTransform) 
- Mapping image to Quad pt.2 [https://github.com/agens-no/AGGeometryKit](https://github.com/agens-no/AGGeometryKit) 
- CATransform3d Cube: [google book](https://books.google.no/books?id=QfhdAAAAQBAJ&pg=PT96&lpg=PT96&dq=CATransform3DMakeTranslation+tz&source=bl&ots=O8sPEcsZ61&sig=ACfU3U3MW2lvhAN4dm4DEb4Nd-m71CJLVA&hl=en&sa=X&ved=2ahUKEwjM6Mjzh__gAhVw_SoKHetkAbsQ6AEwBHoECAUQAQ#v=onepage&q=CATransform3DMakeTranslation%20tz&f=false) 
- Build a cube using CATransform3D:
[https://www.cocoanetics.com/2012/08/cubed-coreanimation-conundrum/](https://www.cocoanetics.com/2012/08/cubed-coreanimation-conundrum/) 
- JS Quad mapping: [http://jsfiddle.net/dFrHS/3/](http://jsfiddle.net/dFrHS/3/) 
- Vanishing point logic: [https://www.handprint.com/HP/WCL/perspect4.html](https://www.handprint.com/HP/WCL/perspect4.html) 
- Vanishing point problem: [https://math.stackexchange.com/questions/1418293/determine-cube-orientation-given-one-side-in-a-perspective-projection?rq=1](https://math.stackexchange.com/questions/1418293/determine-cube-orientation-given-one-side-in-a-perspective-projection?rq=1) 
- AR resources: [https://github.com/olucurious/Awesome-ARKit](https://github.com/olucurious/Awesome-ARKit) 
- GetPerspectiveTransform: [http://answers.opencv.org/question/5018/getperspectivetransform-mathematical-explanation/](http://answers.opencv.org/question/5018/getperspectivetransform-mathematical-explanation/) 

### Todo:
- Add support for 1 point perspective Quadrilaterals ✅
- Add support for horizontal 1p quads (co-linear, epsilon etc) ✅
- Add support for square w/o perspective ✅
