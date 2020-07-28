import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_app/detail.dart';
import 'package:toast/toast.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// final Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<Factory> gestureRecognizers = [
  Factory(() => EagerGestureRecognizer()),
  ].toSet();
  var api = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail';
  var newApi =
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=9efa5194bd6c4c07b48abadc85abebbc';
  var res, drinks, newsRes, news = [], newsData;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Function eq = const ListEquality().equals;

  fetchData() async {
    res = await http.get(api);
    newsRes = await http.get(newApi); 

    // drinks = jsonDecode(res.body)["drinks"];
    newsData = jsonDecode(newsRes.body)["articles"];
    for (int i = 0; i < newsData.length; i++) {
      news.add(newsData[i]);
      // print('hello ${i + 1}');
      setState(() {});
    }
    // print("===========>${news}");
    print("=====+++++++eq++++++++======>${eq(newsData, news)}");
    if (eq(news, news)) {
      showToast("Feed Is Updated", gravity: Toast.BOTTOM);
    }
    print("=====++++++++22222+++++++======>${news.toString()}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar( backgroundColor: hexToColor("#ffcc00", alphaChannel: '1A'),
        title: Text('Live Update', style: TextStyle(color: Colors.black,)),  
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                print("------refrece----");
                fetchData();
                // setState(() {});
              },
              child: Icon(
                Icons.refresh,
                size: 26.0,
                color: Colors.black,
              ),
            ))
      ]),
      body: Center(
        child: res != null
            ? new PageView.builder(
                scrollDirection: Axis.vertical,
                // control: new SwiperControl(
                //   iconPrevious: null,
                //   iconNext: null,
                // ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  var drink = news[index];
                  return PageView(children: <Widget>[
                  TileData(drink: drink, fetchData: (){}),
                  //               Container(
                  // child: WebView(
                  //   initialUrl: drink["url"],
                  //   javascriptMode: JavascriptMode.unrestricted,
                  //   gestureRecognizers: gestureRecognizers,   
                  //   onWebViewCreated: (WebViewController webViewController){
                  //     _controller.complete(webViewController);
                  //   },                                                        
                  // ),
                  //  height: 100,),
                  ],
                  );
                },
              )
            : CircularProgressIndicator(backgroundColor: Colors.white, valueColor: new AlwaysStoppedAnimation<Color>(hexToColor("#ffcc00", alphaChannel: '1A'))),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

// class obj {
//   String urlToImage;
//   String title;
//   String description;
// }




class TileData extends StatefulWidget {
  final Map drink;
  final Function fetchData;
  TileData({Key key, @required this.drink, @required this.fetchData}): super(key: key);

  @override
  _TileDataState createState() => _TileDataState();
}

class _TileDataState extends State<TileData> {
  // var drink = drink; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      // appBar: AppBar(title: Text('Live News'), actions: <Widget>[
      //   Padding(
      //       padding: EdgeInsets.only(right: 20.0),
      //       child: GestureDetector(
      //         onTap: () {
      //           print("------refrece----");
      //           widget.fetchData();
      //           setState(() {});
      //         },
      //         child: Icon(
      //           Icons.refresh,
      //           size: 26.0,
      //         ),
      //       ))
      // ]),
        body: GestureDetector(

        onPanUpdate: (details) {
          print("121212--------------------------------------------->${details.delta.dx}");
          if (details.delta.dx < -15) {
            print("RIRIRIRIRIRRIRIRIRIRIRIRIRIRRIRIRIRIR--------------------------------------------->${details.delta.dx}");
            // swiping in right direction
            Navigator.of(context).push(_createRoute(widget.drink["url"]));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => WebSite(webUrl: widget.drink["url"]),
              //   ),
              // );          
          }
        },

        child:Column(
          children: <Widget>[
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => DrinkDetail(drink: widget.drink),
            //       ),
            //     );
            //   },
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            //       child: Image.network(
            //         widget.drink["urlToImage"] ?? "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
            //         fit: BoxFit.fill,
            //         height: 300.0,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: new Padding(
                padding: new EdgeInsets.all(1.0),             
              child: Container(
                child: new Card(
                  color: Colors.blue[50],
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinkDetail(drink: widget.drink),
                              ),
                            );
                          },
                          // child: Card(
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(15),
                          //   ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'images/liveupdate.png',
                                  image: widget.drink["urlToImage"] ?? "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
                                  fit: BoxFit.fill,
                                  height: 300.0,
                                ),
                              ),
                            ),
                          // ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                          child: Text("${widget.drink["title"]}",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                          child: Text("${widget.drink["description"]}",
                            style: TextStyle(fontSize: 17, color: Colors.grey[800]),
                          )
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ),
            )
            // SizedBox(
            //   height: 30.0,
            // ),
          ],
        ),
      ),
    );
  }
}


class WebSite extends StatefulWidget {
  final String webUrl;
  // final Function fetchData;
  WebSite({Key key, @required this.webUrl}): super(key: key);

  @override
  _WebSiteState createState() => _WebSiteState();
}

class _WebSiteState extends State<WebSite> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  // final Set<Factory> gestureRecognizers = [
  //   Factory(() => EagerGestureRecognizer()),
  //   ].toSet();  

  // RegExp exp = new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  // Iterable<RegExpMatch> matches = exp.allMatches(widget.webUrl);

  @override
  Widget build(BuildContext context) {
    // RegExp exp = new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    // Iterable<RegExpMatch> matches = exp.allMatches(widget.webUrl);
    //   matches.forEach((match) {
    //   print("------------====${widget.webUrl.substring(match.start, match.end)}");
    // });

final urlRegExp = new RegExp(
    r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
final urlMatches = urlRegExp.allMatches(widget.webUrl);
List<String> urls = urlMatches.map(
        (urlMatch) => widget.webUrl.substring(urlMatch.start, urlMatch.end))
    .toList();
urls.forEach((x) => print(x));


    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
    color: Colors.black, //change your color here
  ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Live",
              style:
              TextStyle(color: hexToColor("#ffcc00", alphaChannel: '1A'), fontWeight: FontWeight.w600),
            ),
            Text(
              " Update",
              style: TextStyle(color: hexToColor("#ffcc00", alphaChannel: '1A'), fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                final RenderBox box = context.findRenderObject();
                Share.share(
                  widget.webUrl,
                  subject: '',
                  sharePositionOrigin:
                  box.localToGlobal(Offset.zero) &
                  box.size);
              },
              child: Icon(
                Icons.share,
                size: 26.0,
              ),
            ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),      
      body:  GestureDetector(
        // onPanUpdate: (details) {
        // if (details.delta.dx > 20) {
        //   print("left--------------------------------------------->${details.delta.dx}");
        //   Navigator.pop(context, false);
        // }},
        child:Container(
          child: WebView(
            initialUrl: widget.webUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },          
          // gestureRecognizers: gestureRecognizers,                                       
        ),),),);
  }
}



Route _createRoute(webUrl) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => WebSite(webUrl: webUrl),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  print(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  return new Color(
      int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
//   return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}