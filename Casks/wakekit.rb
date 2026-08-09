cask "wakekit" do
  version "0.1.0"
  sha256 "fce9c969a3ec763efc4859c2c2e4ce401556fc2b13cbc707a50b9938470f6a59"

  url "https://github.com/9zax/wakekit/releases/download/v#{version}/WakeKit-#{version}-aarch64.zip"
  name "WakeKit"
  desc "Menu-bar voice assistant demo: Thai wake words, dictation, and voice commands"
  homepage "https://github.com/9zax/wakekit"

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "WakeKit.app"

  caveats <<~EOS
    WakeKit is ad-hoc signed (no Apple Developer ID). If macOS refuses to open it:
      xattr -dr com.apple.quarantine /Applications/WakeKit.app

    First run asks for Microphone access, and the first wake word asks for
    Speech Recognition. The app lives in the menu bar (flower icon):
    green = listening, red = stopped. Pick your input device under
    Microphone in the tray menu if your system default is a virtual device.
  EOS

  zap trash: [
    "~/Library/WebKit/com.wakekit.demo",
    "~/Library/Caches/com.wakekit.demo",
  ]
end
