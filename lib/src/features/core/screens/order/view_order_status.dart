import 'package:flutter/material.dart';

class ViewOrderStatusScreen extends StatefulWidget {
  const ViewOrderStatusScreen({super.key});

  @override
  State<ViewOrderStatusScreen> createState() => _ViewOrderStatusState();
}

class _ViewOrderStatusState extends State<ViewOrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.cached, color: Colors.amber),
                  text: 'Ongoing'),
              Tab(icon: Icon(Icons.assignment_turned_in_rounded)),
            ],
          ),
          title: const Text('Order Demo'),
        )),
      ),
    );
  }
}
