import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator_plts/app/widget/recource.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int count = 0;
  int totalPages = 2;
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  onNextPage() {
    setState(() {
      pageController.animateToPage(currentPage + 1,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  goToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColor.primaryColor,
        child: Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (int page) => onPageChanged(page),
                    children: <Widget>[
                      _buildPageContent(
                          image: Assets.imgOnboard1,
                          title: "Title Onboarding 1",
                          body:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                          button: GestureDetector(
                            onTap: () => onNextPage(),
                            child: Container(
                              color: Colors.red,
                              child: const Text("data"),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width),
                      _buildPageContent(
                          image: Assets.imgOnboard2,
                          title: "Title Onboarding 2",
                          body:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                          button: Container(
                            color: Colors.red,
                            child: const Text("data"),
                          ),
                          width: MediaQuery.of(context).size.width),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            child: Row(children: [
                              for (int i = 0; i < totalPages; i++)
                                i == currentPage
                                    ? _buildPageIndicator(i, true)
                                    : _buildPageIndicator(i, false)
                            ]),
                          ),
                          GestureDetector(
                            onTap: () =>
                                {currentPage == 0 ? onNextPage() : goToHome()},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  color: AppColor.defaultBlue,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Text(
                                currentPage == 0 ? "Next" : "Home",
                                style: GoogleFonts.montserrat(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget _buildPageContent(
      {required String image,
      required String title,
      required String body,
      required Widget button,
      width}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              image,
              width: width,
            ),
          ),
          const SizedBox(height: 40.0),
          Text(
            title,
            style: TextStyle(
                fontSize: 24.0,
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: AppColor.defaultBlue),
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: Text(body,
                style: GoogleFonts.montserrat(
                    fontSize: 14.0, height: 1.5, color: AppColor.secondText)),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int page, bool isCurrentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 375),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 15.0,
      width: 15.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? AppColor.defaultBlue : AppColor.defaultBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
