import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Viewitemscreen extends StatefulWidget {
  String title;
  String image;
  int price;
  Viewitemscreen({super.key, required this.title, required this.image, required this.price});

  @override
  State<Viewitemscreen> createState() => _ViewitemscreenState();
}

class _ViewitemscreenState extends State<Viewitemscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.image),
                    fit: BoxFit.cover)
                  ),
                ),
            SizedBox(height: 10),
            Text('Price : Rs ${widget.price}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}
