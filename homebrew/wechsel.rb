cask 'wechsel' do
  version '0.2.0'
  sha256 '20acd2fd32d0772f022e2cb50974fed8bd01c514cbd34441adf28fe4ce2ac256'

  url 'https://github.com/friedrichweise/wechsel/releases/download/v0.2-alpha/wechsel_v0.2-alpha.zip'
  appcast 'https://github.com/friedrichweise/wechsel/releases.atom'
  name 'wechsel'
  homepage 'https://github.com/friedrichweise/wechsel'

  app 'wechsel.app'
end