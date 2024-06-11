import 'package:chat_client/src/data/local/config/hive_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/root_state_model.dart';

final appStateProvider = FutureProvider<RootState>(
  (ref) async {
    await HiveConfig.initialize();
    return RootState.success;
  },
);
