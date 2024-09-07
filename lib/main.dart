import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Auto Scroll Widget'),
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

  final GlobalKey _scrollKey = GlobalKey();

  void _scrollToTarget() {
    // Ensure the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _scrollKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1), 
        curve: Curves.easeInOut);
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              _scrollToTarget();
            },
            child: const Text('Scroll to Widget'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 50,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 25) {
                return ListTile(
                  key: _scrollKey,
                  title: const Text("Scroll to Me!")
                );
                }
              return ListTile(title: Text("Item $index"));
            }
          )
        ],
      )
    );
  }
}
