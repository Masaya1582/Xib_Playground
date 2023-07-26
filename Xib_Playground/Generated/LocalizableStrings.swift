// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// A rose by any other name would smell as sweet.
  internal static let sampleText1 = L10n.tr("Localizable", "sample_text1", fallback: "A rose by any other name would smell as sweet.")
  /// It is during our darkest moments that we must focus to see the light.
  internal static let sampleText10 = L10n.tr("Localizable", "sample_text10", fallback: "It is during our darkest moments that we must focus to see the light.")
  /// Ask not what your country can do for you; ask what you can do for your country.
  internal static let sampleText2 = L10n.tr("Localizable", "sample_text2", fallback: "Ask not what your country can do for you; ask what you can do for your country.")
  /// Ask, and it shall be given you; seek, and you shall find.
  internal static let sampleText3 = L10n.tr("Localizable", "sample_text3", fallback: "Ask, and it shall be given you; seek, and you shall find.")
  /// Genius is one percent inspiration and ninety-nine percent perspiration.
  internal static let sampleText4 = L10n.tr("Localizable", "sample_text4", fallback: "Genius is one percent inspiration and ninety-nine percent perspiration.")
  /// In the middle of difficulty lies opportunity.
  internal static let sampleText5 = L10n.tr("Localizable", "sample_text5", fallback: "In the middle of difficulty lies opportunity.")
  /// Be the change that you wish to see in the world.
  internal static let sampleText6 = L10n.tr("Localizable", "sample_text6", fallback: "Be the change that you wish to see in the world.")
  /// Life is what happens when you're busy making other plans.
  internal static let sampleText7 = L10n.tr("Localizable", "sample_text7", fallback: "Life is what happens when you're busy making other plans.")
  /// The only limit to our realization of tomorrow will be our doubts of today.
  internal static let sampleText8 = L10n.tr("Localizable", "sample_text8", fallback: "The only limit to our realization of tomorrow will be our doubts of today.")
  /// Success is not final, failure is not fatal: It is the courage to continue that counts.
  internal static let sampleText9 = L10n.tr("Localizable", "sample_text9", fallback: "Success is not final, failure is not fatal: It is the courage to continue that counts.")
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
