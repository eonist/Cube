#if os(iOS)
import UIKit
public typealias View = UIView
public typealias Color = UIColor
public typealias HybridView = UIView
#elseif os(macOS)
import Cocoa
public typealias View = NSView/*View is NOT layered-backed for macOS*/
public typealias Color = NSColor
public typealias HybridView = LayerView/*HybridView is layered-backed*/
#endif

