import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'drawer.dart';

void main() {
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
      ),


      home: MyHomePage(),

      supportedLocales: [
        Locale( 'ar' , '' )
      ],

      localeResolutionCallback: (currentLocale , supportedLocales ){
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
      appBar: AppBar( title: Center(child: Text('home')),),

     body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
            //     image: AssetImage("images/home.jpg"),
            //     // fit: BoxFit.cover,
            //   ),
            // ),
            child: Stack(
              children: [

                

            

                


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 40,left: 30,right: 30,bottom: 30),
                  child:  Text('  اخبار القسم  ',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),)
                  ],
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: ( BuildContext context , int position ){
                      return
                    Column(
                      
                      children: [
                          Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30,bottom: 30 ),
                          
                          child: Row(
                          children: <Widget>[
                    
                            SizedBox(width: 20,),
                            Expanded(
                              child: Column(                 
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                Text('title' ,style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                                  
                                ),),
                                SizedBox(height: 15,),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('sub text', style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),),  
                              ],
                              )
                              ],
                            )
                            )
                          ],
                      ),
                        ),
              ]
                      );
                    
                    // SizedBox(height: 50,),
            
                    // Padding(padding: EdgeInsets.only(left: 30,right: 30),child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                    // ),),
                    
                    // Divider()        

            },

          ),
                ),


    Row(
           mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Image(image: AssetImage("images/home.jpg"), width: 500, height: 400,  ),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(image: AssetImage("images/logo1.png"), width: 90,height: 70,  ),
              
            ],
          ),

          Container(
            margin: const EdgeInsets.only(top: 7 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Image(image: AssetImage("images/Logoo2.png" ,), height: 60,  width: 90)
              ],
            ),
          ),
              ],
            )
            
            
            
            
            
            
      ),
    );
  }
}
