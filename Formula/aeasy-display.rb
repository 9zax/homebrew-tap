class AeasyDisplay < Formula
  desc "Android phone as a second display for your Mac, over USB-C or Wi-Fi"
  homepage "https://github.com/9zax/aeasy-display"
  url "https://github.com/9zax/aeasy-display/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "1a662deee7fdfc53797e8a2372a0787013c70892ec3a682359c19f9cbfb34fbe"
  license "MIT"

  depends_on :macos

  # prebuilt viewer APK from the matching release (building it needs the Android SDK)
  resource "apk" do
    url "https://github.com/9zax/aeasy-display/releases/download/v0.3.0/app-debug.apk"
    sha256 "5828237cca1bff9ae80624eb538dd1cb8b9da1aee5b610069d0d357f89f4dbd8"
  end

  def install
    system "make", "build"
    pkgshare.install "mac/aeasy-server", "mac/aeasy-config", "mac/aeasy-tray", "docs/logo.svg"
    resource("apk").stage { pkgshare.install "app-debug.apk" }
    # the CLI keeps config/logs in ~/.local/share/aeasy but the binaries live in the Cellar
    inreplace "bin/aeasy" do |s|
      s.gsub! 'SERVER="$SHARE/aeasy-server"', "SERVER=\"#{opt_pkgshare}/aeasy-server\""
      s.gsub! 'CONFIGAPP="$SHARE/aeasy-config"', "CONFIGAPP=\"#{opt_pkgshare}/aeasy-config\""
      s.gsub! 'APK="$SHARE/app-debug.apk"', "APK=\"#{opt_pkgshare}/app-debug.apk\""
      s.gsub! '"$SHARE/aeasy-tray"', "\"#{opt_pkgshare}/aeasy-tray\""
    end
    bin.install "bin/aeasy"
  end

  def caveats
    <<~EOS
      aeasy needs adb:
        brew install --cask android-platform-tools

      First run: grant Screen Recording (video) and Accessibility (touch input)
      to aeasy-server in System Settings > Privacy & Security, then `aeasy restart`.

      Install the viewer app onto the plugged-in phone with:
        aeasy install-app
    EOS
  end

  test do
    assert_match "aeasy", shell_output("#{bin}/aeasy help")
  end
end
