import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String _childMessage = 'Waiting for data...';

  // Screens for BottomNavigationBar
  final List<Widget> _widgetOptions = <Widget>[
    FirstTab(),  // Navegación push/pop
    DataTransferTab(),  // Envío de datos entre padre e hijo
    Text('Profile Tab'),  // Placeholder for another tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateMessageFromChild(String message) {
    setState(() {
      _childMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Navigation Example'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Data Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// First Tab: Push and Pop Navigation Example
class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondScreen()),
          );
        },
        child: Text('Go to Second Screen'),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}

// Second Tab: Data Transfer Example (Parent to Child, Child to Parent)
class DataTransferTab extends StatefulWidget {
  @override
  _DataTransferTabState createState() => _DataTransferTabState();
}

class _DataTransferTabState extends State<DataTransferTab> {
  String _parentMessage = 'Waiting for data from child...';
  
  void _sendDataToParent(String message) {
    setState(() {
      _parentMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_parentMessage),
        ChildWidget(onSendData: _sendDataToParent),
        ParentToChildWidget(data: 'Hello from Parent!'),
      ],
    );
  }
}

// Child to Parent communication
class ChildWidget extends StatelessWidget {
  final Function(String) onSendData;

  ChildWidget({required this.onSendData});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onSendData('Hello from Child!');
      },
      child: Text('Send Data to Parent'),
    );
  }
}

// Parent to Child communication
class ParentToChildWidget extends StatelessWidget {
  final String data;

  ParentToChildWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
