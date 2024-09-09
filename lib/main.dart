import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get_it/get_it.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/app_strings.dart';
import 'package:tampay_mobile/base/pref_data.dart';
import 'package:tampay_mobile/manager/auth_manager.dart';
import 'app/profile/presentation/controller/profile_controller.dart';
import 'app/routes/app_pages.dart';

final getIt = GetIt.instance;

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    generateDeviceId();
    registerDependencyInjection().then((_) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          primaryColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashRoute,
      routes: AppPages.routes,
    );
  }

  Future<void> registerDependencyInjection() async {
    await getIt.registerSingleton<AuthManager>(AuthManager());
  }

  Future<String?> generateDeviceId() async {
    try {
      String udid = await FlutterUdid.udid;
      PrefData().setStringValue(AppStrings.deviceIdString, udid);
      return udid;
    } catch (e) {
      return null;
    }
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getIt<AuthManager>().loadAuthDetails();
      // Check if token is available and valid
      final token = getIt<AuthManager>().token;
      if (token != null && token.isNotEmpty) {
        // Token exists, fetch the user profile
        ref.read(profileControllerProvider).getProfile();
      }
    });
  }
}
