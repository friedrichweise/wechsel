#  <a href="https://wechsel.weise.io/">wechsel</a>

wechsel (`/ˈvɛksəl/`) claims to simplify the interaction with  bluetooth connections on macOS. Instead of using the builtin Bluetooth menu bar, you can seamlessly switch between bluetooth audio devices using your keyboard. The tool offers a global hotkey to display a Spotlight-like window. It seeks to be a more generic alternative for similar tools like <a href="https://c-command.com/toothfairy/">ToothFairy</a> and <a href="https://www.producthunt.com/posts/airbuddy-2">AirBuddy</a>.
The implementation is based on the work of  <a href="https://github.com/toy/blueutil">blueutil</a> and utilizes the system level <a href="https://developer.apple.com/documentation/iobluetooth">IOBluetooth</a> framework.

<img src="screenshot.jpg" width="100%" alt="Screenshot"/>


### Installation

Install using homebrew:
```sh
brew cask install friedrichweise/wechsel/wechsel
```
or download the application from the <a href="https://github.com/friedrichweise/wechsel/releases">release-page</a>.

#### Problem: “wechsel.app” is damaged and can’t be opened. You should move it to the Bin.
Run:
```sh
xattr -cr /Applications/wechsel.app
```

### Development Setup
```sh
git clone git@github.com:friedrichweise/wechsel.git
carthage update --platform macos
open wechsel.xcodeproj
```

### Create a new release
* update version Number in "Project Settings" -> "Target" -> "wechsel"
* run "Product" -> "Archive"
* draft an new release on github and upload the zipped `wechsel.app`
* publish the release
* edit wechsel.ruby in `/usr/local/Homebrew/Library/Taps/friedrichweise/homebrew-wechsel/Casks`
    * bump version number
    * update checksum for zip file
    * run `brew style wechsel` and `brew audit wechsel`
    * push changes to https://github.com/friedrichweise/homebrew-wechsel

### Dependencies
* <a href="https://github.com/shpakovski/MASShortcut">MASShortcut</a> v2.4
* <a href="https://github.com/sindresorhus/LaunchAtLogin">LaunchAtLogin</a> v4.2.0
* <a href="https://github.com/zemirco/swift-timeago">swift-timeago</a>
