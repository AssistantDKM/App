import 'package:redux/redux.dart';

import '../../../contracts/redux/app_state.dart';
import '../setting/actions.dart';
import '../setting/selector.dart';

class HomePageViewModel {
  final bool hasAcceptedIntro;

  final void Function() setHasAcceptedIntro;

  HomePageViewModel({
    required this.hasAcceptedIntro,
    //
    required this.setHasAcceptedIntro,
  });

  static HomePageViewModel fromStore(Store<AppState> store) =>
      HomePageViewModel(
        hasAcceptedIntro: getHasAcceptedIntro(store.state),
        //
        setHasAcceptedIntro: () => store.dispatch(ToggleHasAcceptedIntro()),
      );
}
