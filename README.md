![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg) ![platform](https://img.shields.io/badge/Platform-iOS-blue.svg) ![platform](https://img.shields.io/badge/Platform-macOS-blue.svg) ![Lang](https://img.shields.io/badge/Language-Swift%204.2-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![codebeat badge](https://codebeat.co/badges/a14b185c-f5ec-4fab-ae83-6141e4f24a24)](https://codebeat.co/a/30n1st/projects/github-com-eonist-cube-master)

# Cube

<img width="320" alt="img" src="https://github.com/stylekit/img/blob/master/Screenshot 2019-03-15 at 16.58.07.png?raw=true">

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

### Todo:
- Add support for 1 point perspective Quadrilaterals
- Add support for square w/o perspective
