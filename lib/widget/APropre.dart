import 'package:flutter/material.dart';

// ignore: camel_case_types
class aproposcren extends StatelessWidget {
  const aproposcren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
              maxRadius: 120,
              minRadius: 120,
            ),
            SizedBox(height: 300),
            Text(
                'copyright caisse-national sécurite Sociale 2021/09/09\ Version 1'),
          ],
        ),
      ),
    );
  }
}
