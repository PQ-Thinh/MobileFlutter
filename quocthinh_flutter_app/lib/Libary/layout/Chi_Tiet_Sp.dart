import 'package:flutter/material.dart';

class PageChitiet extends StatefulWidget {
  const PageChitiet({super.key});

  @override
  State<PageChitiet> createState() => _PageChitietState();
}

class _PageChitietState extends State<PageChitiet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiet"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed:(){
              Navigator.of(context).pop("Bye");
            },
            child: Text("Go back")),
      ),
    );
  }
}
