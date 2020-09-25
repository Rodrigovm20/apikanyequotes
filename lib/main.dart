import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MyApp());
}


Future<Quotes> fetchQuote() async{
  final response = await http.get('https://api.kanye.rest/');

  if (response.statusCode == 200){
    return Quotes.fromJson(json.decode(response.body));
  } else {
    throw Exception('Hubo un error en la recepción de datos');
  }
}


class Quotes {
  final String quote;
  
  Quotes({this.quote});
  factory Quotes.fromJson(Map<String,dynamic> json){
    return Quotes(quote: json['quote']);
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanye West Quotes',
      theme: ThemeData(
        
        primarySwatch: Colors.red,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Kanye West Quotes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Future<Quotes> futureQuote;
  
  

  @override

  void initState() {
    super.initState();
  futureQuote= fetchQuote();
  }

void _new(){
  setState(() {
      
      futureQuote= fetchQuote();
    });
  
}

  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
   
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Quotes>(
          future: futureQuote,
          builder: (context, snapshot){
            if (snapshot.hasData){
                return Center(
                  child: Column(children: <Widget>[
                    Text(snapshot.data.quote),
                    
                    Image.network('https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTU0OTkwNDUxOTQ5MDUzNDQ3/kanye-west-attends-the-christian-dior-show-as-part-of-the-paris-fashion-week-womenswear-fall-winter-2015-2016-on-march-6-2015-in-paris-france-photo-by-dominique-charriau-wireimage-square.jpg')
        
                  ],)
                );
            }
          }
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _new,
       child: Icon(Icons.more),
      ),
    );
  }
}
