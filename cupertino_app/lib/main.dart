import 'package:cupertino_app/model/app.state.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider<AppStateModel>(
        create: (_) => AppStateModel()..loadProducts(),
        child: const CupertinoStoreApp()),
  );
}
