import 'package:doitly/custom_button.dart';
import 'package:doitly/login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class OnBoardingModel {
  final String title;
  final String description;
  final Widget image;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnBoardingModel> onboardingModels = [
    OnBoardingModel(
      title: 'Welcome to Doitly',
      description: 'Your personal task management app that helps you stay organized and productive.',
      image: const Icon(Icons.task_alt, size: 200, color: Color(0xFF2072FA)),
    ),
    OnBoardingModel(
      title: 'Organize Your Tasks',
      description: 'Create, manage, and prioritize your tasks with ease. Set priorities and never miss important deadlines.',
      image: const Icon(Icons.checklist, size: 200, color: Color(0xFF2072FA)),
    ),
    OnBoardingModel(
      title: 'Take Notes',
      description: 'Capture your thoughts, ideas, and important information in one place.',
      image: const Icon(Icons.note_add, size: 200, color: Color(0xFF2072FA)),
    ),
  ];

  int currentPage = 0;
  final CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Doitly'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2072FA),
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const login_screen()),
              );
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: onboardingModels.length,
                itemBuilder: (context, index, realIndex) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    onboardingModels[index].image,
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            onboardingModels[index].title,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2072FA),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            onboardingModels[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          DotsIndicator(
                            dotsCount: onboardingModels.length,
                            position: currentPage.toDouble(),
                            decorator: const DotsDecorator(
                              color: Colors.grey,
                              size: Size.square(9.0),
                              activeColor: Color(0xFF2072FA),
                              activeSize: Size(18.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                options: CarouselOptions(
                  height: 400,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                ),
              ),
            ),
            custom_button(
              onPressed: () {
                if (currentPage == onboardingModels.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const login_screen()),
                  );
                } else {
                  setState(() {
                    currentPage++;
                    carouselController.animateToPage(currentPage);
                  });
                }
              },
              text: currentPage == onboardingModels.length - 1 ? 'Get Started' : 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
