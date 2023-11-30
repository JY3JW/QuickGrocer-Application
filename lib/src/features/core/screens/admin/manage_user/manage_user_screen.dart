import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/controllers/manage_user_controller.dart';
import 'package:quickgrocer_application/src/features/core/screens/admin/manage_user/add_user_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/admin/manage_user/update_user_screen.dart';
import 'package:quickgrocer_application/src/repository/user_repository/user_repository.dart';

class ManageUserScreen extends StatefulWidget {
  const ManageUserScreen({super.key});

  @override
  State<ManageUserScreen> createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  late List<UserModel> user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageUserController());
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            manageUser,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => Get.to(() => AddUserScreen()),
                icon: Icon(
                  Icons.add_box,
                  color: iconColorWithoutBackground,
                ))
          ],
        ),
        body: Container(
            margin: const EdgeInsets.all(17.0),
            child: Column(children: [
              Expanded(
                  child: FutureBuilder(
                      future: controller.getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            user = snapshot.data as List<UserModel>;

                            return _buildAllUsers(user);
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          } else {
                            return const Center(
                                child: Text("Something went wrong"));
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }))
            ])));
  }

  // user list widget
  _buildAllUsers(List<UserModel> users) => ListView.builder(
      itemCount: users.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateUserScreen(user: user[index]))),
            child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(users[index].fullName),
                subtitle: Text(users[index].email),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text('Delete User'),
                                content: Text('Confirm to delete this user?'),
                                actions: [
                                  ElevatedButton(
                                    child: Text('NO'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  ElevatedButton(
                                    child: Text('YES'),
                                    onPressed: () => {
                                      setState(() {
                                        UserRepository.instance
                                            .deleteUserRecord(users[index]);
                                      }),
                                      Navigator.pop(context),
                                    },
                                  ),
                                ]));
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                )));
      }));
}
