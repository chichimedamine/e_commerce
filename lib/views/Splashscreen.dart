import 'package:e_commerce/views/index.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../helper/ColorsHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Index()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsHelper.gray300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  LucideIcons.store,
                  size: 100,
                  color: ColorsHelper.black,
                ),
              ),
              const SizedBox(height: 20),
              LoadingAnimationWidget.staggeredDotsWave(
                color: ColorsHelper.black,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
