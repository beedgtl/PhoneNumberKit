import Foundation

// MARK: - CurrentBundleFinder

private class CurrentBundleFinder {}

extension Bundle {
  /// Бандл, вместо `Bundle.module` для того чтобы ассеты были доступны в `PreviewProvider`
  /// - Ссылка на тред, где описана проблема и решение: https://forums.swift.org/t/unable-to-find-bundle-in-package-target-tests-when-package-depends-on-another-package-containing-resources-accessed-via-bundle-module/43974/2
  static var phoneNumberKit: Bundle = {
    let bundleName = "PhoneNumberKit_PhoneNumberKit"
    let localBundleName = "LocalPackages_PhoneNumberKit"

    let candidates = [
      /* Bundle should be present here when the package is linked into an App. */
      Bundle.main.resourceURL,

      /* Bundle should be present here when the package is linked into a framework. */
      Bundle(for: CurrentBundleFinder.self).resourceURL,

      /* For command-line tools. */
      Bundle.main.bundleURL,

      /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
      Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
      Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
    ]

    for candidate in candidates {
      let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
      if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
        return bundle
      }

      let localBundlePath = candidate?.appendingPathComponent(localBundleName + ".bundle")
      if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
        return bundle
      }
    }

    fatalError("unable to find bundle")

  }()
}
