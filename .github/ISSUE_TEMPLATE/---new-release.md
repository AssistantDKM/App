---
name: "\U0001F4E6 New Release"
about: Steps to release a new version
title: Release 1.xx
labels: pre-release
assignees: Khaoz-Topsy

---

### Prepare:
- [ ] Make sure that `pubspec.yaml` uses github link for the `assistantapps_flutter_common` library
- [ ] Make sure content of `release_notes.txt` is ready for production
- [ ] Run the versionNumberScript `dart scripts\versionNumScript.dart`
- [ ] Create new item in Admin tool
  - [ ] Copy content of `release_notes.txt` to Markdown
  - [ ] Future date release date
  - [ ] Copy guid, paste into `assistantAppsSettings.dart`
- [ ] Create Pull Request
- [ ] [Queue](https://codemagic.io/app/641d82730d82a528c46ca76a/settings) CodeMagic build 

---

### Later:
- [ ] Merge Pull Request on successful build and deploy
- [ ] Create Github release ([New Release](https://github.com/AssistantDKM/App/releases/new))
  - [ ] Tag develop branch (1.x.x)
  - [ ] Use appropriate tag (1.x.x)
  - [ ] Attach `.aab`
  - [ ] Attach `.apk`
  - [ ] Attach `.ipa`
  - [ ] Attach `.exe`
- [ ] Go through manual iOS steps
  - [ ] Copy content of `release_notes.txt` into Apple webpage
  - [ ] Submit for Apple review
- [ ] Go through manual WindowsStore steps
  - [ ] Copy content of `release_notes.txt` into store webpage
  - [ ] Submit for Microsoft review

