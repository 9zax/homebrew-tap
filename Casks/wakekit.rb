cask "wakekit" do
  version "0.2.1"
  sha256 "00e6ff74882db879ca5057bb98494d64b7c24eb8e543febef8ea6ffd514f1b08"

  url "https://github.com/9zax/wakekit/releases/download/app-v#{version}/WakeKit-#{version}-aarch64.zip"
  name "WakeKit"
  desc "Menu-bar voice assistant demo: Thai wake words, dictation, and voice commands"
  homepage "https://github.com/9zax/wakekit"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "WakeKit.app"

  caveats <<~EOS
    WakeKit is ad-hoc signed (no Apple Developer ID). If macOS refuses to open it:
      xattr -dr com.apple.quarantine /Applications/WakeKit.app

    First run asks for Microphone access, and the first wake word asks for
    Speech Recognition. The app lives in the menu bar (flower icon):
    green = listening, red = stopped. Pick your input device under
    Microphone in the tray menu if your system default is a virtual device.

    Dictation is Apple's: a Mac that has never dictated Thai needs it turned
    on once, with ไทย in its languages, under
    System Settings > Keyboard > Dictation. Without it the wake word still
    fires but nothing is transcribed.
  EOS

  zap trash: [
    "~/Library/WebKit/com.wakekit.demo",
    "~/Library/Caches/com.wakekit.demo",
  ]
end
