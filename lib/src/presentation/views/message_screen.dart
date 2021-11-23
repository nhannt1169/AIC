import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("thieen__aan"),
        elevation: 1.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
            leading: const SizedBox(
              width: 60.0,
              height: 60.0,
              child: CircleAvatar(
                child: ClipOval(
                  child: Image(
                    height: 60.0,
                    width: 60.0,
                    image: AssetImage("assets/images/Kroni.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: const Text(
              "Kronii",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text("hello! "),
            trailing: Material(
              color: Colors.white,
              child: IconButton(
                splashRadius: 20,
                icon: const Icon(
                  Icons.favorite_border,
                ),
                color: Colors.grey,
                iconSize: 27,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
