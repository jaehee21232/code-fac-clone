import 'package:code_fac/common/const/colors.dart';
import 'package:code_fac/common/const/data.dart';
import 'package:code_fac/common/layout/deafult_layout.dart';
import 'package:code_fac/common/view/root_tab.dart';
import 'package:code_fac/user/view/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //deleteToken();
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
    final tokens = await storage.read(key: REFRESH_TOKEN_KEY);
    print("delete");
    print(tokens);
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessTOken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessTOken == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => RootTab(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/img/logo/logo.png",
                width: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 16,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
