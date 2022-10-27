import 'package:ferdinand_coffee/core/routes.dart';
import 'package:ferdinand_coffee/pages/home/home.dart';
import 'package:ferdinand_coffee/pages/login/login.dart';
import 'package:ferdinand_coffee/provider/Favorites_product.dart';
import 'package:ferdinand_coffee/provider/add_product_provider.dart';
import 'package:ferdinand_coffee/provider/cart.dart';
import 'package:ferdinand_coffee/provider/product_Details.dart';
import 'package:ferdinand_coffee/provider/profile_provider.dart';
import 'package:ferdinand_coffee/provider/shipping_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/product_provider2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_live_51JM9SwLWhuTtrTL4r7CSKBJCSTwABzpoUzKW6emJu0J1XV1uSKFIXZtiMA6kKkl397LlpG4XeEbLdAEs3UJONYch00CYz5p6zb";
  // Stripe.merchantIdentifier = 'ferdinandcoffee';
  // await Stripe.instance.applySettings();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ProductDetailsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ShippingAddressProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AddProductProviderAdmin(),
      ),
    ], child: MyApp(prefs: prefs)));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.prefs}) : super(key: key);
  final SharedPreferences? prefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool? isEnglish = widget.prefs?.getBool("isEnglish");
    bool? alreadyLoggedIn = widget.prefs?.getBool("loggedIn");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ProductProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => FavoritesProductProvider()),
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          routes: routes,
          debugShowCheckedModeBanner: false,
          title: 'Ferdinand Coffee',
          locale: isEnglish == true && isEnglish != null
              ? const Locale("en")
              : const Locale("de"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('de', ''), // Spanish, no country code
          ],
          theme: ThemeData(
            fontFamily: 'Avenir',
            primarySwatch: Colors.brown,
          ),
          initialRoute: HomePage.routeName,
          darkTheme: ThemeData(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
