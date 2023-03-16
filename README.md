<div align="center">
  
  # Assistant for Dinkum
  ### Android, iOS & Web app built in Flutter  
  ![header](https://github.com/AssistantDKM/.github/blob/main/img/header-rounded.png?raw=true)
  
  <br />
  
  ![madeWithLove](https://github.com/AssistantDKM/.github/blob/main/img/made-with-love.svg)
  [![licence](https://github.com/AssistantDKM/.github/blob/main/img/licence-badge.svg)](https://github.com/AssistantDKM/.github/blob/main/LICENCE.md)
  [![gitmoji](https://github.com/AssistantDKM/.github/blob/main/img/gitmoji.svg?raw=true)](https://gitmoji.dev)<br />
  [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://github.com/AssistantDKM/.github/blob/main/CODE_OF_CONDUCT.md)
  ![Profile views](https://komarev.com/ghpvc/?username=AssistantDKM&color=green&style=for-the-badge)

  [![Mastodon](https://img.shields.io/mastodon/follow/109315859662532146?color=%2300ff00&domain=https%3A%2F%2Fnomanssky.social&style=for-the-badge&logo=mastodon)][mastodon]
  [![Discord](https://img.shields.io/discord/625007826913198080?style=for-the-badge&label=Chat%20on%20Discord&logo=discord)][discord]<br />
  [![Follow on Twitter](https://img.shields.io/twitter/follow/AssistantNMS?color=%231d9bf0&style=for-the-badge&logo=twitter)][assistantnmsTwitter]<br />
  
  [![Latest version](https://api.assistantapps.com/badge/version/e9fb4e7e-79d8-c5a2-79fa-e206b0681780.svg?platforms=0&platforms=1)](*)
  
  <br /> 
</div>


<!-- <div align="center">

  [![PlayStore](https://github.com/AssistantDKM/.github/blob/main/img/PlayStore.png?raw=true)][googlePlayStore]
  [![AppStore](https://github.com/AssistantDKM/.github/blob/main/img/AppStore.png?raw=true)][appleAppStore]
  [![PWA](https://github.com/AssistantDKM/.github/raw/main/img/webVersion2.png?raw=true)][webapp]
  
</div> -->
 

The **Assistant for Dinkum** is an app that gives users information about the game, such as animal locations, recipes, details about town people and more!

![divider](https://github.com/AssistantDKM/.github/blob/main/img/divider1.png)

## 🏃‍♂️ Running the project
  
### Requirements
- Almost any desktop computer (eg.. MacOS X, Linux, Windows)
- An IDE with (e.g. IntelliJ, Android Studio, VSCode etc)
- [Flutter][flutter] installed and in your **PATH** environment variable

### Steps:
1. Clone this repository
2. Rename the `env.dart.template` file to `env.dart`
3. In the directory where the `pubspec.yaml` file is, run `flutter pub get`
4. Run the app
   - If you want to run the app as an Android app, have the Android emulator running, ensure that the device is showing in the results of this command: `flutter devices` and use the command `flutter run`
   - If you want to run the app as a Windows application, use the command `flutter run -d windows`

![divider](https://github.com/AssistantDKM/.github/blob/main/img/divider1.png)

## 👪 Contributing
**Project Owner**: [Khaoz-Topsy][kurtGithub]<br /><br />
Please take a look at the [Contribution Guideline](https://github.com/AssistantDKM/.github/blob/main/CONTRIBUTING.md) before creating an issue or pull request.

If you would like to help add languages to the app please use this tool [AssistantApps tool][assistantAppsTools].

![divider](https://github.com/AssistantDKM/.github/blob/main/img/divider1.png)

## 📦 Builds (CI/CD)
The Mobile Apps are built and released to the [Google Play Store][googlePlayStore] and [Apple App Store Store][appleAppStore] using [CodeMagic][codeMagic].

- ![Codemagic build status](https://api.codemagic.io/apps/5d9da9057a0a9500105180bf/5ef3374ec0adbfe0fdee431d/status_badge.svg) - Android & iOS (Production)
- ![Codemagic build status](https://api.codemagic.io/apps/5d9da9057a0a9500105180bf/5d9dc56b7a0a95000a475d84/status_badge.svg) - iOS Build

__The iOS build on [CodeMagic][codeMagic] generally reports that it has failed even though it actually successfully built and pushed the `.ipa` file to the Apple App Store. This is because they poll the App Store checking if the `.ipa` file is there and after a few attempts throw an error. So ignore build failures for anything that has to do with iOS 🙄.__

![divider](https://github.com/AssistantDKM/.github/blob/main/img/divider1.png)

## 🔗 Links

[![Website](https://img.shields.io/badge/Website-assistantapps.com/dkm-blue?color=7986cc&style=for-the-badge)][website] <br />
[![WebApp](https://img.shields.io/badge/Web%20App-dinkum.assistantapps.com-blue?color=7986cc&style=for-the-badge)][webapp]

[![GooglePlay](https://img.shields.io/badge/Download-Google%20Play%20Store-blue?color=34A853&style=for-the-badge)][googlePlayStore] <br />
[![AppleAppStore](https://img.shields.io/badge/Download-Apple%20App%20Store-black?color=333333&style=for-the-badge)][appleAppStore]

[![Twitter](https://img.shields.io/badge/Twitter-@AssistantNMS-blue?color=1DA1F2&style=for-the-badge)][assistantnmsTwitter] <br />
[![Discord](https://img.shields.io/badge/Discord-AssistantApps-blue?color=5865F2&style=for-the-badge)][discord] <br />



<!-- Links used in the page -->

[kurtGithub]: https://github.com/Khaoz-Topsy?ref=Ass[[](https://github.com/AssistantDKM/.github/blob/main)](https://github.com/AssistantDKM/.github/blob/main)Github
[assistantAppsTools]: https://tools.assistantapps.com?ref=AssistantDKMGithub
[website]: https://assistantapps.com/dkm?ref=AssistantDKMGithub
[webapp]: https://dinkum.assistantapps.com?ref=AssistantDKMGithub
[assistantnmsTwitter]: https://twitter.com/AssistantNMS?ref=AssistantDKMGithub
[googlePlayStore]: https://play.google.com/store/apps/details?id=com.assistantapps.dinkum&ref=AssistantDKMGithub
[appleAppStore]: https://apps.apple.com/us/app/assistant-for-no-mans-sky/id1480287625?ref=AssistantDKMGithub
[windowsStore]: https://apps.microsoft.com/store/detail/assistant-for-no-mans-sky/9NQLF7XD0LF3?ref=AssistantDKMGithub
[discord]: https://assistantapps.com/discord?ref=AssistantDKMGithub
[mastodon]: https://nomanssky.social/@assistantnms?ref=AssistantDKMGithub
[nmscd]: https://github.com/NMSCD?ref=AssistantDKMGithub

<!-- Other -->
[mbincompiler]: https://github.com/monkeyman192/MBINCompiler
[flutter]: https://docs.flutter.dev/get-started/install
[androidStudio]: https://developer.android.com/studio
[codeMagic]: https://codemagic.io
