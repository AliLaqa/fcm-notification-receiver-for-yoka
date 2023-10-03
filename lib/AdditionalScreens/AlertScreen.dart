import 'package:flutter/material.dart';
import 'package:notification_receiver_yoka/Screens/HomeScreen.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AlertScreen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent.shade200.withOpacity(0.9),
      ),
      body:  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // image: DecorationImage(image: AssetImage("assets/bg_home.jpg"),
          //     fit: BoxFit.cover, alignment: Alignment.center, repeat: ImageRepeat.noRepeat),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text("Go to HomeScreen")),
            ],
          ),
        ),
      ),
    );
  }
}
