import 'package:flutter/material.dart';
import 'package:repair_tech_lab/home_screen.dart';
import 'package:repair_tech_lab/Page/Home.dart';
import 'package:repair_tech_lab/Page/Page2.dart';
import 'package:repair_tech_lab/Page/Page3.dart';
import 'package:repair_tech_lab/Page/Page4.dart';
import 'package:repair_tech_lab/Page/Page5.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late bool _isDarkMode = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleTheme(bool value) {
    setState(
      () {
        _isDarkMode = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      myAnimatedLogo(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                );
              case '/home':
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MyAppHomePage(
                    isDarkMode: _isDarkMode,
                    toggleTheme: _toggleTheme,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                );
              case '/page1':
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Home(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                );
            }

            return null;

            // '/page2': (context) => const Page2(),
            // '/page3': (context) => const Page3(),
            // '/page4': (context) => const Page4(),
            // '/page5': (context) => const Page5(),
          },
        );
      },
    );
  }

  Scaffold myAnimatedLogo() {
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(_navigatorKey.currentState!.context)
              .pushReplacementNamed('/home');
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: _animation.value,
              child: Image.asset(
                'assets/logo.png',
                height: 200,
                width: 200,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Opacity(
              opacity: _animation.value,
              child: const Text(
                'Repair Tech Lab',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppHomePage extends StatefulWidget {
  const MyAppHomePage({
    Key? key,
    required this.isDarkMode,
    required this.toggleTheme,
  }) : super(key: key);

  final bool isDarkMode;
  final ValueChanged<bool> toggleTheme;

  @override
  State<MyAppHomePage> createState() => _MyAppHomePageState();
}

class _MyAppHomePageState extends State<MyAppHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 36,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          "Repair Tech Lab",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Switch(
              activeColor: Colors.white10,
              activeTrackColor: Colors.white70,
              inactiveThumbColor: Colors.black87,
              inactiveTrackColor: Colors.black12,
              value: widget.isDarkMode,
              onChanged: widget.toggleTheme,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 6,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  title: const Text(
                    'Головна',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigate to Page 1
                    Navigator.popAndPushNamed(context, '/page1');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Послуги',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigate to Page 2
                    Navigator.popAndPushNamed(context, '/page2');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Про нас',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigate to Page 3
                    Navigator.popAndPushNamed(context, '/page3');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Контакти',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigate to Page 4
                    Navigator.popAndPushNamed(context, '/page4');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Запис на ремонт',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Navigate to Page 5 with custom fade transition
                    Navigator.popAndPushNamed(context, '/page5');
                  },
                ),
              ],
            ).toList(),
          ),
        ),
      ),
      body: const MainHomeContent(),
    );
  }
}
