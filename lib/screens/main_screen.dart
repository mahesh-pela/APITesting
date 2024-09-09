import 'package:bucketlist/screens/AddBucketListScreen.dart';
import 'package:bucketlist/screens/ViewItemScreen.dart';
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
  bool isError = false;


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
      isError = false;
      setState(() {});

      print(response.data);
    } catch (e) {
      isLoading = false;
      isError = true;
      setState(() {
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();

  }

  Widget errorWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text('Error getting bucketlist Data'),
          ElevatedButton(
              onPressed: getData,
              child: Text("Try Again")
          )
        ],
      ),
    );
  }

  Widget ListDataWidget(){
    return ListView.builder(
        itemCount: bucketListData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewitemscreen(
                title: bucketListData[index]['item'] ?? "",
                image: bucketListData[index]['image']??"",
                price: bucketListData[index]['price'] ?? "",
              )));
            },
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage(bucketListData[index]['image'] ?? ""),
            ),
            title: Text(bucketListData[index]['item'] ?? ""),
            trailing: Text(bucketListData[index]['price'].toString() ?? ""),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Addbucketlistscreen()));
        },
        child: Icon(Icons.add,color: Colors.white,),
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,
      ),
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
        child: isLoading ? Center(child: CircularProgressIndicator()) : isError ? errorWidget() :
          ListDataWidget()
        ),
    );
  }
}
