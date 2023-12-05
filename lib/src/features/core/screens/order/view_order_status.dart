import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class ViewOrderStatusScreen extends StatefulWidget {
  const ViewOrderStatusScreen({super.key});

  @override
  State<ViewOrderStatusScreen> createState() => _ViewOrderStatusState();
}

class _ViewOrderStatusState extends State<ViewOrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cached, color: Colors.amber),
                  Text('Ongoing', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.done, color: AppColors.subLimeColor),
                  Text('Completed', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
            ],
          ),
          title: const Text(orderHistoryTitle),
        )),
      ),
    );
  }
}
