import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'components/adaptive/app_shell.dart';
import 'contracts/redux/app_state.dart';
import 'env/environment_settings.dart';
import 'integration/dependency_injection.dart';
import 'redux/create_store.dart';
import 'redux/setting/actions.dart';
import 'redux/setting/selector.dart';

class DinkumApp extends StatefulWidget {
  final EnvironmentSettings env;
  const DinkumApp(this.env, {Key? key}) : super(key: key);

  @override
  createState() => _DinkumAppState();
}

class _DinkumAppState extends State<DinkumApp> {
  late Store<AppState>? store;
  late TranslationsDelegate _newLocaleDelegate;

  @override
  initState() {
    super.initState();
    initDependencyInjection(widget.env);
    initReduxState();

    if (kReleaseMode) {
      // initFirebaseAdMob();
    }
  }

  Future<void> initReduxState() async {
    Store<AppState> tempStore = await createStore();
    setState(() {
      store = tempStore;
    });
    // ignore: unnecessary_null_comparison
    if (tempStore != null && tempStore.state != null) {
      _newLocaleDelegate = TranslationsDelegate(
        newLocale: Locale(getSelectedLanguage(tempStore.state)),
      );
    }
  }

  void _onLocaleChange(Locale locale) {
    if (store == null) return;
    store!.dispatch(ChangeLanguageAction(locale.languageCode));
    setState(() {
      _newLocaleDelegate = TranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (store == null) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: Text('Loading')),
        ),
      );
    }

    return StoreProvider(
      store: store!,
      child: AppShell(
        key: const Key('app-shell'),
        newLocaleDelegate: _newLocaleDelegate,
        onLocaleChange: _onLocaleChange,
      ),
    );
  }
}
