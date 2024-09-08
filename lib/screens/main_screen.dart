import 'package:bucketlist/screens/ViewScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }
  Future<void> getData() async {

    setState(() {
      isLoading = true;
    });
    try {
      //fetch data from the API
      Response response = await Dio().get(
          "https://fluttertestapi-92512-default-rtdb.firebaseio.com/bucketList.json");
      //assigning response data to the bucketListData
      bucketListData = response.data;
      isLoading = false;
      setState(() {});

      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Bucket List',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: getData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh, size: 25,),
              )
          )
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async{
          getData();
        },
        child: isLoading ? Center(child: CircularProgressIndicator()) :
        ListView.builder(
              itemCount: bucketListData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(bucketListData[index]['image'] ?? ""),
                  ),
                  title: Text(bucketListData[index]['item'] ?? ""),
                  trailing: Text(bucketListData[index]['price'].toString() ?? ""),
                );
              }),
        ),
    );
  }
}
