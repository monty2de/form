import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(title: Text('الرئيسية'), centerTitle: true),
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
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
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
                            'جدول امتحانات الفصل الاول',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'تم نشر جدول امتحانات الفصل الاول',
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
          ),
        ],
      ),
    );
  }
}
