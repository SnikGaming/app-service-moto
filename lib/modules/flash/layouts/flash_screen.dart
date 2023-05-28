import 'package:app/constants/colors.dart';
import 'package:app/modules/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with TickerProviderStateMixin {
  // Biến xác định trạng thái kết nối hiện tại
  bool _isConnected = true;

  late final AnimationController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _checkInternet() async {
    Future.delayed(const Duration(seconds: 6))
        .then((value) => {Modular.to.navigate(Routes.home)});
    // Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    //   setState(() {
    //     _isConnected = (result != ConnectivityResult.none);

    //     if (_isConnected) {
    //       Message.success(message: "Welcome to app! 💕💕", context: context);
    //       Future.delayed(const Duration(seconds: 6))
    //           .then((value) => {Modular.to.navigate(Routes.home)});
    //     } else {
    //       Message.error(
    //           message:
    //               "Please check if your device is connected to the internet 🤷‍♂️🤷‍♂️",
    //           context: context);
    //     }
    //   });
    // });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {FlutterNativeSplash.remove()});
    _checkInternet();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: black,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Lottie.asset('assets/flashscreen/routine.json',
                      repeat: false, height: size.height),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Lottie.asset('assets/banners/7n69eEGbIn.json',
                          controller: _controller, onLoaded: (onload) {
                        _controller
                          ..duration = onload.duration
                          ..forward();
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      SpinKitFadingCircle(
                          itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      }),
                      const Spacer(),
                      const Text(
                        'By development',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 46,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
