import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/categories_provider.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/provider/item_provider.dart';
import 'package:ecommerce_app/provider/user_provider.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/route/screen_export.dart';
import 'package:ecommerce_app/screens/splash/splash.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/route/router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<ItemProvider>(create: (_) => ItemProvider()),
        ChangeNotifierProvider<CategoriesProvider>(
            create: (_) => CategoriesProvider()),
        ChangeNotifierProvider<FavoriteProvider>(
            create: (_) => FavoriteProvider()..getFavoriteItem()),
        ChangeNotifierProvider(create: (_) => CartProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: splashRoute,
      theme: ThemeData(
          primaryColor: primary50,
          fontFamily: 'Satoshi',
          textTheme: const TextTheme(
              bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              bodyMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              displayLarge:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
              displayMedium:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              displaySmall:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFFebefff))),
      home: const Splash(),
    );
  }
}
