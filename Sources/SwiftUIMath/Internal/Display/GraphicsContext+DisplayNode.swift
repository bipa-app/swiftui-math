import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension GraphicsContext {
  func draw(_ displayNode: Math.DisplayNode, size: CGSize, foregroundColor: Color) {
    var context = self

    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1, y: -1)
    context.translateBy(x: 0, y: displayNode.descent)

    let cgForeground: CGColor
    if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *) {
      cgForeground = foregroundColor.resolve(in: environment).cgColor
    } else {
      #if canImport(UIKit)
      cgForeground = UIColor(foregroundColor).cgColor
      #elseif canImport(AppKit)
      cgForeground = NSColor(foregroundColor).cgColor
      #endif
    }

    context.withCGContext { cgContext in
      cgContext.draw(displayNode, foregroundColor: cgForeground)
    }
  }

  func draw(_ displayNode: Math.DisplayNode, size: CGSize, with shading: GraphicsContext.Shading) {
    var context = self

    context.fill(Path(CGRect(origin: .zero, size: size)), with: shading)
    context.blendMode = .destinationIn

    context.drawLayer {
      $0.draw(displayNode, size: size, foregroundColor: .black)
    }
  }
}
