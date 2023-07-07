import 'package:app/functions/random_color.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

class MyTestProfile extends StatefulWidget {
  const MyTestProfile({super.key});

  @override
  State<MyTestProfile> createState() => _MyTestProfileState();
}

class _MyTestProfileState extends State<MyTestProfile> {
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  /// and then assign it to the our widget library
  Widget float1() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        heroTag: "btn1",
        tooltip: 'First button',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        heroTag: "btn2",
        tooltip: 'Secondd button',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[float1(), float2()],
          key: key,
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 80,
              width: size.width,
              color: randomColor(),
            )
          ],
        ),
      ),
    );
  }
}
