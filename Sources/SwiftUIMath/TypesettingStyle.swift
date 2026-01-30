import SwiftUI

extension Math {
  /// Controls how math is typeset (display vs inline text).
  public enum TypesettingStyle: Sendable {
    /// Display style for standalone equations.
    case display
    /// Text style for inline math.
    case text
  }
}

extension View {
  /// Sets the typesetting style for ``Math`` views in this hierarchy.
  public func mathTypesettingStyle(_ typesettingStyle: Math.TypesettingStyle) -> some View {
    environment(\.mathTypesettingStyle, typesettingStyle)
  }
}

private struct MathTypesettingStyleKey: EnvironmentKey {
  static let defaultValue: Math.TypesettingStyle = .display
}

extension EnvironmentValues {
  var mathTypesettingStyle: Math.TypesettingStyle {
    get { self[MathTypesettingStyleKey.self] }
    set { self[MathTypesettingStyleKey.self] = newValue }
  }
}
