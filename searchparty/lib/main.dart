import 'package:flutter/cupertino.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'SearchParty',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(
          'SearchParty',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('4 you'),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Friends', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage('https://picsum.photos/60?image=${index + 1}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Parties', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: CupertinoColors.systemGrey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Party ${index + 1}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  Text('Location ${index + 1}'),
                                  Text('Time: ${DateTime.now().add(Duration(hours: index)).toString()}'),
                                  SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, friendIndex) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage('https://picsum.photos/40?image=${friendIndex + 1}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BottomNavBar(isActive: isActive, onToggleActive: () {
              setState(() {
                isActive = !isActive;
              });
            }),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final bool isActive;
  final VoidCallback onToggleActive;

  const BottomNavBar({Key? key, required this.isActive, required this.onToggleActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: CupertinoColors.systemGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.house_fill, color: CupertinoColors.activeBlue),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.add, color: CupertinoColors.activeBlue),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const CreateEventPage(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(isActive ? CupertinoIcons.circle_fill : CupertinoIcons.circle, color: CupertinoColors.activeBlue),
            onPressed: onToggleActive,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.chat_bubble, color: CupertinoColors.activeBlue),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ChatPage(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.person, color: CupertinoColors.activeBlue),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Create Event'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  CupertinoTextField(placeholder: 'Event Name'),
                  CupertinoTextField(placeholder: 'Location'),
                  CupertinoTextField(placeholder: 'Date and Time'),
                  CupertinoTextField(placeholder: 'Description'),
                  CupertinoTextField(placeholder: 'Invite Friends'),
                ],
              ),
            ),
            BottomNavBar(isActive: true, onToggleActive: () {}),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Chat'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CupertinoListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/40?image=${index + 1}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text('Friend ${index + 1}'),
                    subtitle: Text('Last message...'),
                    trailing: const Icon(CupertinoIcons.chevron_right),
                    onTap: () {
                      // Navigate to individual chat
                    },
                  );
                },
              ),
            ),
            BottomNavBar(isActive: true, onToggleActive: () {}),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Profile'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/100'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Active', style: TextStyle(color: CupertinoColors.activeGreen)),
                  Text('Instagram: @johndoe'),
                  Text('Twitter: @johndoe'),
                  Text('Facebook: John Doe'),
                ],
              ),
            ),
            BottomNavBar(isActive: true, onToggleActive: () {}),
          ],
        ),
      ),
    );
  }
}
