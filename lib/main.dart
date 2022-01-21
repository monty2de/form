import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form/Controllers/NewsController.dart';
import 'package:form/models/news.dart';
import 'package:form/views/login.dart';
import 'package:form/views/news/news_add.dart';
import 'package:form/views/news/news_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final role = await getvalidationData();
  runApp(MyApp(role: role));
}

class MyApp extends StatelessWidget {
  final int role;

  const MyApp({Key? key, this.role = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.light(
            primary: Colors.blue[900]!,
            // secondary: Colors.blue[900]!,
          ),
          primaryColor: Colors.blue[900],
          appBarTheme: AppBarTheme(color: Colors.blue[900])),
      home: role == 0 ? Login() : MyHomePage(role: role),
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

Future<int> getvalidationData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var role = sharedPreferences.getInt('role');

  if (role == null) {
    return 0;
  } else if (role == 1 || role == 2 || role == 3 || role == 4) {
    return role;
  } else {
    return 0;
  }
}

class MyHomePage extends StatefulWidget {
  final int role;

  const MyHomePage({Key? key, this.role = 0}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// ignore: non_constant_identifier_names
  late int role_check;

  @override
  void initState() {
    role_check = widget.role;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(role_check),
      appBar: AppBar(actions: [
        role_check == 1
            ? TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewsAdd(role_check);
                  }));
                },
                child:
                    Text(" اضافة خبر ", style: TextStyle(color: Colors.white)),
              )
            : Container(),
      ], title: Text('الرئيسية'), centerTitle: true),
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
            future: NewsController().index(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  return _loading();
                  // ignore: dead_code
                  break;
                case ConnectionState.waiting:
                  return _loading();
                  // ignore: dead_code
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Container();
                  }
                  if (snapshot.hasData) {
                    return result(snapshot.data, context);
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

  Widget result(List<News> news, BuildContext context) {
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
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        news[position].title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      onTap: () {
                        if (this.role_check == 1 || this.role_check == 2) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NewsUpdate(this.role_check, news[position]);
                          }));
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      news[position].body,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    this.role_check == 1 || this.role_check == 2
                        ? InkWell(
                            child: Text(
                              'حذف',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                            onTap: () {
                              NewsController().delet(news[position].id);
                              setState(() {});
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
