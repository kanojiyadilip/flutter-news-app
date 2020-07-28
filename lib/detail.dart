import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:zoomable_image/zoomable_image.dart';
// import 'main.dart';

class DrinkDetail extends StatelessWidget {
  final drink;

  const DrinkDetail({Key key, @required this.drink}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.indigo,
        Colors.indigo,
      ])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // title: Text(drink["description"]),
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                // tag: drink["title"],
                tag: drink["title"],
                child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),),                  
                  child: Image.network(
                      drink["urlToImage"] ??
                          "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
                    fit: BoxFit.fill,
                    // width: 150.0,
                    height: 300.0,
                  ),
                ),

                // child: CircleAvatar(
                //   radius: 100.0,
                //   backgroundImage: NetworkImage(
                //     drink["urlToImage"],
                //   ),
                // ),
              ),
              SizedBox(
                height: 30.0,
              ),
              // Text(
              //   "${drink["title"]}",
              //   style: TextStyle(
              //     color: Colors.white,
              //   ),
              // ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                child: Column(children: <Widget>[

                ],),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //   child:Text(
                //   "${drink["description"]}",
                //   style: TextStyle(
                //     fontSize: 20,
                //     color: Colors.white,
                //   ),
                // ),
              ),
              RaisedButton(
                onPressed: () => _launchURL(drink["url"]),
                child: Text('Know More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL(link) async {
  // const url = 'https://flutter.dev';
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}
