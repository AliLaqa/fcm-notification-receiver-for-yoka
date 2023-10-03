import 'package:flutter/material.dart';
import 'package:notification_receiver_yoka/AdditionalScreens/AlertScreen.dart';
import 'package:notification_receiver_yoka/AdditionalScreens/MessageScreen.dart';
import 'package:notification_receiver_yoka/AdditionalScreens/OtherScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/bg_home.jpg"), 
              fit: BoxFit.cover, alignment: Alignment.center, repeat: ImageRepeat.noRepeat),
        ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AlertScreen()));
                    }, 
                    child: Text("AlertScreen", style: TextStyle(color: Colors.white),)),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen()));
                    },
                    child: Text("MessageScreen", style: TextStyle(color: Colors.white),)),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OtherScreen()));
                    },
                    child: Text("OtherScreen", style: TextStyle(color: Colors.white),)),
              ],
            ),
          ),
      ),
    );
  }
}
