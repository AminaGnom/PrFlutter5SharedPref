import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.title});

  final String title;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
 String data ="Переданная строка:";


  @override
  Widget build(BuildContext context) {
    String takedString = (ModalRoute.of(context)?.settings.arguments ?? "пусто") as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$data$takedString',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
             child: Text("Главное  окно")
            ), 
           
          ],
        ),
      ),
    );
  }
}
