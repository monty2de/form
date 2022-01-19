import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form/Controllers/NewsController.dart';
import 'package:form/models/news.dart';
import 'package:form/views/login.dart';
import 'package:form/views/news_add.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.blue[900])),
      home: MyHomePage(),
      supportedLocales: [Locale('ar', '')],
      localeResolutionCallback: (currentLocale, supportedLocales) {
        return supportedLocales.first;
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int role;

  const MyHomePage(
      {Key? key,
      this.role = 0  ,
      })
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

var role_check;

Future getvalidationData() async {
 SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var role = sharedPreferences.getInt('role');
  setState(() {
      role_check = role;
  });

}

@override
void initState() {
    getvalidationData().whenComplete(() async{
      Timer(Duration(seconds: 2), (){
        print(role_check);

        if (role_check == 0) {

          Navigator.push(context,
          MaterialPageRoute(builder: (context) {
          return Login( );
          }));
          
        }
      });
    });

    
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(role_check),
      appBar: AppBar(
        actions: [

          
            role_check == 1 ? TextButton(
            onPressed: () {
             
             
             Navigator.push(context,
      MaterialPageRoute(builder: (context) {
      return NewsAdd(role_check);
     }));
            },
            child: Text(" اضافة خبر ", style: TextStyle(color: Colors.white)),
          ) :Container(),
        ],
        title: Text('الرئيسية'), centerTitle: true),
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage("images/home.jpg"),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                margin: const EdgeInsets.only(top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                        image: AssetImage("images/Logoo2.png"),
                        height: 60,
                        width: 90),
                    Image(
                      image: AssetImage("images/logo1.png"),
                      width: 90,
                      height: 70,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'اخبار القسم',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Divider(thickness: 2),
          SizedBox(height: 10),

          FutureBuilder(
            future:   NewsController().index(),
            builder: ( BuildContext context , AsyncSnapshot snapshot ){
    
              switch ( snapshot.connectionState ){
    
                
                case ConnectionState.done :
                  if(snapshot.hasError){
                    return Container();
                  }
                  if(snapshot.hasData){
                    return result(snapshot.data , context);
                  }
                  break;
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  break;
                case ConnectionState.active:
                  break;
              }
              return Container();
            },
          ),
          
        ],
      ),
    );
  }


  Widget result( List<News> news , BuildContext context ){

    
  return Expanded(
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: news.length,
                itemBuilder: (BuildContext context, int position) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 30),
                        child: Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              news[position].title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 15),
                            Text(
                              news[position].body,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        )),
                      ),
                    ],
                  );
                },
              ),
  );
  
}
}
