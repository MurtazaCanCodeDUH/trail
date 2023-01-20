import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:webview_windows/webview_windows.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _controller0 = WebviewController();
  final _controller1 = WebviewController();
  final _controller2 = WebviewController();
  final _textController0 = TextEditingController();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await _controller1.initialize();
      await _controller2.initialize();
      await _controller0.initialize();
      _controller1.url.listen((url) {
        _textController1.text = url;
      });
      _controller2.url.listen((url) {
        _textController2.text = url;
      });
      _controller0.url.listen((url) {
        _textController0.text = url;
      });

      await _controller1.setBackgroundColor(Colors.deepPurpleAccent);
      await _controller1.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller1
          .loadUrl('https://reeborg.ca/reeborg.html?lang=en&mode=python');
      await _controller2.setBackgroundColor(Colors.deepPurpleAccent);
      await _controller2.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller2.loadUrl('https://reeborg.ca/reeborg.html');
      await _controller0.setBackgroundColor(Colors.deepPurpleAccent);
      await _controller0.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller0.loadUrl('https://reeborg.ca/reeborg.html');

      if (!mounted) return;
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${e.code}'),
                      Text('Message: ${e.message}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }

  Widget compositeView() {
    if (!_controller1.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Webview(
                    _controller1,
                    permissionRequested: _onPermissionRequested,
                  ),
                  StreamBuilder<LoadingState>(
                      stream: _controller1.loadingState,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data == LoadingState.loading) {
                          return LinearProgressIndicator();
                        } else {
                          return SizedBox();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Center(
          child: Text(
            "Day 2",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                      });
                    },
                    height: 50,
                    minWidth: 100,
                    color: const Color(0xff361553),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      "Tutorial",
                      style: TextStyle(
                          fontFamily: "Syne",
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffffff),
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _counter = 1;
                      });
                    },
                    height: 50,
                    minWidth: 100,
                    color: const Color(0xff361553),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      "Map 1",
                      style: TextStyle(
                          fontFamily: "Syne",
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffffff),
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _counter = 2;
                      });
                    },
                    height: 50,
                    minWidth: 100,
                    color: const Color(0xff361553),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      "Map 2",
                      style: TextStyle(
                          fontFamily: "Syne",
                          fontWeight: FontWeight.bold,
                          color: Color(0xffffffff),
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            _counter == 0?
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 20,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/first.png',)),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(image: AssetImage('assets/second.png',)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/third.png',), ),
                    )
                    ,Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/fourth.png',), ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/fifth.png',)),
                    )
                  ],
                ),
              )
            ) : _counter == 1?
            Expanded(
              child: Stack(
                children: [
                  Webview(
                    _controller1,
                    permissionRequested: _onPermissionRequested,
                  ),
                ],
              ),
            ):
            Expanded(
              child: Stack(
                children: [
                  Webview(
                    _controller2,
                    permissionRequested: _onPermissionRequested,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }
}
