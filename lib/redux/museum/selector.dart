import '../../contracts/redux/app_state.dart';

List<String> getDonations(AppState state) => state.museumState.donations;
