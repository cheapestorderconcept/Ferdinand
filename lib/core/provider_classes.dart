import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../provider/profile_provider.dart';

List<ChangeNotifierProvider> providers(_) {
  return [
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
    ),
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
    ),
  ];
}
