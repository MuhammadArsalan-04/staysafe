import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:provider/provider.dart';

import 'package:stay_safe_user/configurations/color_constants.dart';
import 'package:stay_safe_user/infrastructure/providers/friends_provider.dart';
import 'package:stay_safe_user/infrastructure/providers/friends_request_provider.dart';
import 'package:stay_safe_user/infrastructure/providers/user_details_provider.dart';
import 'package:stay_safe_user/infrastructure/providers/username_provider.dart';
import 'package:stay_safe_user/presentation/safety_app_view/bottom_navigation_bar/bottom_navigation.dart';
import 'configurations/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider.value(value: UsernameProvider()),
        ChangeNotifierProvider.value(value: UserDetailsProvider()),
        ChangeNotifierProvider.value(value: FriendsRequestProvider()),
        ChangeNotifierProvider.value(value: FriendsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashscreen',
        title: 'Stay Safe',
        theme: ThemeData(
            useMaterial3: true,
            
            primaryColor: ColorConstants.kPrimaryColor,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
            ),
            cardTheme: const CardTheme(
                surfaceTintColor: Colors.white, color: Colors.white)),
        routes: Routes.routes,
        home: BottomNavigation(),
      ),
    );
  }
}

/*

context.loaderOverlay.show();

setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });

    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }

 */