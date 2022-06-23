import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator_plts/app/widget/recource.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onNavigate();
  }

  onNavigate() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        Navigator.pushReplacementNamed(context, '/onboarding');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                Assets.imgLogoSplash,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Kalkulator PLTS",
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColor.defaultBlue),
            )
          ],
        ),
      ),
    );
  }
}
