import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addbucketlistscreen extends StatefulWidget {
  const Addbucketlistscreen({super.key});

  @override
  State<Addbucketlistscreen> createState() => _AddbucketlistscreenState();
}

class _AddbucketlistscreenState extends State<Addbucketlistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bucket List'),
      ),
    );
  }
}
