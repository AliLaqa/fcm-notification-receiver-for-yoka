import 'package:flutter/material.dart';
import 'package:notification_receiver_yoka/Screens/HomeScreen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MessageScreen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade300.withOpacity(0.9),
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
