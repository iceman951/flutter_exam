import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: Column(
        children: [
          Spacer(flex: 2),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second_page');
              },
              child: Text('second page')),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list_page');
              },
              child: Text('list')),
          Spacer(flex: 2),
        ],
      )),
    );
  }
}
