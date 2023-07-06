// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Work Hard, Have Fun, Make History
  internal static let walkthroughAmazon = L10n.tr("Localizable", "walkthrough_amazon", fallback: "Work Hard, Have Fun, Make History")
  /// Think Different
  internal static let walkthroughApple = L10n.tr("Localizable", "walkthrough_apple", fallback: "Think Different")
  /// Move fast and break things
  internal static let walkthroughFacebook = L10n.tr("Localizable", "walkthrough_facebook", fallback: "Move fast and break things")
  /// Make life easier with a little help from our products.
  internal static let walkthroughGoogle = L10n.tr("Localizable", "walkthrough_google", fallback: "Make life easier with a little help from our products.")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
