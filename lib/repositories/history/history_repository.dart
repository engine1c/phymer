import 'package:realm/realm.dart';

import 'history.dart';

class HistoryRepository implements HistoryRepositoryInterface {
  final Realm realm;

  HistoryRepository({required this.realm});

  @override
  Future<List<HistoryRhymes>> getRhymesList() async {
    return realm.all<HistoryRhymes>().toList();
  }

  @override
  Future<void> clear() async {
    realm.write(() => realm.deleteAll<HistoryRhymes>());
  }

  @override
  Future<void> setRhymes(HistoryRhymes rhymes) async {
    realm.write(() => realm.add(rhymes));
  }
}
