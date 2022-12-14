
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreferences/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/':(context) => MyHomePage(title: 'Практическая работа №5'),
        '/screen':(context) => SecondPage(title: 'Сохранено')
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String save ="";
  late SharedPreferences ShPref;


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ShPref.setInt("counter", _counter);
  }
  Future<void> initShared() async{
    ShPref = await SharedPreferences.getInstance();
  }
  
  @override
  void initState(){
    initShared().then((value) {
      _counter=ShPref.getInt('counter') ?? 0;
      save =ShPref.getString('savedString')??"пусто";
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _controller= TextEditingController();



    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(244, 232, 146, 53),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Строка для сохранения: $save',
              style: TextStyle(
                fontSize: 40,
                foreground: Paint()
               ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.blue[600]!,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.only(top:50.0),
                child:TextFormField(controller: _controller,
                decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Введите что-нибудь!",
                fillColor: Colors.black12,
                filled: true
                ),
              ),
            ),
          Container(
           child: ElevatedButton(
            onPressed: (){
                Navigator.pushNamed(context, '/screen', arguments: _controller.text);
                ShPref.setString("savedString", _controller.text);
                _controller.clear();
            },
           
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.red),
                // margin: const EdgeInsets.all(10)
              
            ),
             child: Text("Сохранение")
            ), 
          ),


          ],
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Показать последнее сохраненное значение',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
