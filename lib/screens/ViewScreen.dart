import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Viewscreen extends StatefulWidget {
  const Viewscreen({super.key});

  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Column(
          children: [
            // NetworkImage(bucketListData)
          ],
        ),
      ),
    );
  }
}
