import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyHomePage(),
));

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  addicon(String url, double size, var icon, var col){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(icon: Icon(icon,
          size: size,
          color: col,
        ), onPressed: () {
          pageloading(true);
          setState(() {
            isclick = false;
            isclick2 = false;
            strurl = url;
            if(!strurl.startsWith("https://")){
              strurl = "https://"+strurl;
            }
            if(_webViewController != null){
              _webViewController.loadUrl(strurl).then((onValue){
              });
            }});
        }),
      ),
    );
  }

  backicon(double size, bool what, var icon){
    return IconButton(icon: Icon(icon,
      size: size,
      color: Colors.grey[300],
    ), onPressed: () {
      setState(() {
        if(what){
        isclick = !isclick;}
        else{
          isclick2 = !isclick2;
        }
      });
    });
  }

  WebViewController _webViewController;
  bool isclick = false;
  bool back = false;
  bool isclick2 = false;
  String strurl = "https://google.com";
  String tempurl = "";
  bool isloading = false;
  var currenturl  = null;
  bool thirdpartyapp = false;
  bool openinfo = false;
  List<String> Prevurl = ["https://www.google.com/"];
  int present = 0;
  int last = 0;

  presenturl() async{
    if(!back){
      currenturl = await _webViewController.currentUrl();
      if(currenturl == Prevurl[present]){}
      else{
        present += 1;
        last += 1;
        Prevurl.add(currenturl);
      }
    }
    if(present <= 0){
      present = 0;
    }
      print("from here  ");
      print(currenturl);
      print(present);
      print(last);
      print(Prevurl);
      print("   to here");
  }

  pageloading(bool change){
    presenturl();
    setState(() {
      if(!change){
        back = false;
      }
      isloading = change;
    });
  }

  goback(){
    if(present == 0){

    }
    else {
      setState(() {
        back = true;
        pageloading(true);
        present -= 1;
        Prevurl.removeLast();
        currenturl = Prevurl[present];
        if (_webViewController != null) {
          _webViewController.loadUrl(currenturl).then((onValue) {});
        }
        last = present;
      });
    }
  }

  Widget appbar(){
    if(isclick){
      openinfo = false;
      thirdpartyapp = false;
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("www. ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[300],
              ),),
              Container(
                width: MediaQuery.of(context).size.width-180,
                child: TextField(
                  onChanged: (val){
                    tempurl = val;
                  },
                  onSubmitted: (val) {
                    setState(() {
                      isclick = !isclick;
                      strurl = val;
                      if(!strurl.startsWith("https://")){
                        strurl = "https://"+strurl;
                      }
                      if(_webViewController != null){
                        _webViewController.loadUrl(strurl).then((onValue){
                        });
                      }});
                  },
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 20,
                  ),
                    decoration: InputDecoration(
                      hintText: "Enter URL here",
                    ),
                ),
              ),
              addicon(tempurl, 25, Icons.arrow_forward, Colors.black),
              backicon(20, true, Icons.arrow_back_ios),
            ],
          ),
          scrollDirection: Axis.horizontal,
        ),
      );
    }
    else if(isclick2){
      thirdpartyapp = false;
      openinfo = false;
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.teal,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                addicon("https://google.com", 25,
                    FontAwesomeIcons.google, Colors.blue[500]),
                addicon("https://accounts.google.com/signin/v2/identifier?flowName=GlifWebSignIn&flowEntry=ServiceLogin"
                    , 25,
                    FontAwesomeIcons.googlePlus, Colors.red[900]),
                addicon("https://youtube.com", 22,
                    FontAwesomeIcons.youtube, Colors.red[800]),
                addicon("https://facebook.com", 25,
                    FontAwesomeIcons.facebook, Colors.indigoAccent),
                addicon("https://github.com/Tushargupta9800", 25,
                    FontAwesomeIcons.github, Colors.black),
                addicon("https://twitter.com/explore", 25,
                    FontAwesomeIcons.twitter, Colors.indigoAccent),
                addicon("https://www.wikipedia.org/", 20,
                    FontAwesomeIcons.wikipediaW, Colors.black),
                addicon("https://in.yahoo.com/", 25,
                    FontAwesomeIcons.yahoo, Colors.black),
                backicon(20, false, Icons.arrow_back_ios),
              ],
            ),
          scrollDirection: Axis.horizontal,
          ),
        );
    }
    else{
      return Container(
        width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          color: Colors.teal,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Stack(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          openinfo = !openinfo;
                          thirdpartyapp = false;
                        });
                      },
                      child: Text(
                        'Web Browser',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(width: 10.0,),
                Stack(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.search,
                      size: 30,
                      color: Colors.grey[300],
                    ), onPressed: () {
                      setState(() {
                        isclick = !isclick;
                      });
                    }),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40.0,
                        ),
                        Text("Search",
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                          ),)
                      ],
                    ),
                  ],
                ),
                addicon("https://google.com", 20, FontAwesomeIcons.google, Colors.blue[500]),
                backicon(20, false, Icons.keyboard_arrow_down),
                IconButton(icon: Icon(Icons.refresh,
                color: Colors.grey[300],
                ), onPressed: () async {
                  thirdpartyapp = false;
                  openinfo = false;
                  await presenturl();
                  pageloading(true);
                  strurl = currenturl;
                  if(_webViewController != null){
                    _webViewController.loadUrl(strurl).then((onValue){
                    });
                  }}),
                IconButton(icon: Icon(FontAwesomeIcons.running,
                  size: 20,),
                  onPressed: () async {
                    await presenturl();
                    setState(() {
                      openinfo = false;
                      thirdpartyapp = !thirdpartyapp;
                    });
                  },
                ),
              ],
            ),
            scrollDirection: Axis.horizontal,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: appbar(),
              ),
              Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Stack(
                    children: <Widget>[
                      WebView(
                        initialUrl: strurl,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (webViewController){
                          _webViewController = webViewController;
                        },
                        onPageStarted: (data) => pageloading(true),
                        onPageFinished: (data) => pageloading(false),
                      ),
                      (isclick2)?Container(
                        color: Colors.teal,
                        height: 35,
                        width: 35,
                        child: IconButton(icon: Icon(Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.grey[300],), onPressed: () => goback()),
                      ):Container(),
                      (isloading)?Center(child: Loading(
                        indicator: LineScaleIndicator(),
                        color: Colors.teal,
                      ))
                          :Container(),
                      (openinfo)?Center(
                        child: Container(
                          color: Colors.black54,
                          height: 180,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "About me:-\nTushar Gupta, I'm currently(2020) pursuing\nB.Tech in "
                                    "Information Technology from\nIndian Institute of Information"
                                    "Texhnology,\nAllahabad  You can find me "
                                    "on Github along\nwith my other Projects. My Github Handle:-\n"
                                    "https://github.com/Tushargupta9800",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(onPressed: () {setState(() {
                                    openinfo = false;
                                  });},
                                    child:
                                    Text("Ok", style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.grey[900],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                          :Container(),
                      (thirdpartyapp)?Center(
                        child: Container(
                          color: Colors.black54,
                          height: 102,
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                " Are you sure to open the\n same page in a third\n party browser?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(onPressed: () {setState(() {
                                    thirdpartyapp = false;
                                    launch(currenturl);
                                          });},
                                    child:
                                  Text("Yes", style: TextStyle(color: Colors.white),
                                   ),
                                    color: Colors.grey[900],
                                  ),
                                  FlatButton(onPressed: () {setState(() {
                                    thirdpartyapp = false;
                                          });},
                                    child:
                                  Text("No",
                                    style: TextStyle(color: Colors.white),
                                   ),
                                    color: Colors.grey[900],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                          :Container(),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}