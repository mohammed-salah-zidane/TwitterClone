// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum DINNextLTArabic {
    internal static let black = FontConvertible(name: "DINNextLTArabic-Black", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNextLTArabic-Black.ttf")
    internal static let bold = FontConvertible(name: "DINNextLTArabic-Bold", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNextLTArabic-Bold.ttf")
    internal static let heavy = FontConvertible(name: "DINNextLTArabic-Heavy", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNextLTArabic-Heavy.ttf")
    internal static let light = FontConvertible(name: "DINNextLTArabic-Light", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNEXTLTARABIC-LIGHT.ttf")
    internal static let medium = FontConvertible(name: "DINNextLTArabic-Medium", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNextLTArabic-Medium.ttf")
    internal static let regular = FontConvertible(name: "DINNextLTArabic-Regular", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNextLTArabic-Regular.ttf")
    internal static let ultraLight = FontConvertible(name: "DINNextLTArabic-UltraLight", family: "DIN Next LT Arabic", path: "ArbFONTS-DINNextLTArabic-UltraLight.ttf")
    internal static let all: [FontConvertible] = [black, bold, heavy, light, medium, regular, ultraLight]
  }
  internal enum Manrope3 {
    internal static let bold = FontConvertible(name: "Manrope3-Bold", family: "Manrope3", path: "Manrope3-Bold.otf")
    internal static let extraBold = FontConvertible(name: "Manrope3-ExtraBold", family: "Manrope3", path: "Manrope3-ExtraBold.otf")
    internal static let light = FontConvertible(name: "Manrope3-Light", family: "Manrope3", path: "Manrope3-Light.otf")
    internal static let medium = FontConvertible(name: "Manrope3-Medium", family: "Manrope3", path: "Manrope3-Medium.otf")
    internal static let regular = FontConvertible(name: "Manrope3-Regular", family: "Manrope3", path: "Manrope3-Regular.otf")
    internal static let semibold = FontConvertible(name: "Manrope3-Semibold", family: "Manrope3", path: "Manrope3-Semibold.otf")
    internal static let thin = FontConvertible(name: "Manrope3-Thin", family: "Manrope3", path: "Manrope3-Thin.otf")
    internal static let all: [FontConvertible] = [bold, extraBold, light, medium, regular, semibold, thin]
  }
  internal enum Roboto {
    internal static let black = FontConvertible(name: "Roboto-Black", family: "Roboto", path: "Roboto-Black.ttf")
    internal static let bold = FontConvertible(name: "Roboto-Bold", family: "Roboto", path: "Roboto-Bold.ttf")
    internal static let light = FontConvertible(name: "Roboto-Light", family: "Roboto", path: "Roboto-Light.ttf")
    internal static let medium = FontConvertible(name: "Roboto-Medium", family: "Roboto", path: "Roboto-Medium.ttf")
    internal static let regular = FontConvertible(name: "Roboto-Regular", family: "Roboto", path: "Roboto-Regular.ttf")
    internal static let thin = FontConvertible(name: "Roboto-Thin", family: "Roboto", path: "Roboto-Thin.ttf")
    internal static let all: [FontConvertible] = [black, bold, light, medium, regular, thin]
  }
  internal static let allCustomFonts: [FontConvertible] = [DINNextLTArabic.all, Manrope3.all, Roboto.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(OSX)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
