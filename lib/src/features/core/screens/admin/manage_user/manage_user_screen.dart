import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/controllers/manage_user_controller.dart';
import 'package:quickgrocer_application/src/features/core/screens/admin/manage_user/add_user_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/grocery_card.dart';
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
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor =
        isDark ? AppColors.mainPineColor : AppColors.subPistachioColor;
    var iconLineColor = isDark ? Colors.white : Colors.black;

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
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(17.0),
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                future: controller.getAllUsers(),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<UserModel> user = snapshot.data as List<UserModel>;
                      // Controllers
                      //final _email = TextEditingController(text: user.email);
                      //final name = TextEditingController(text: user.fullName);
                    
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              userList,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headlineSmall
                            ),

                            const SizedBox(width: 120.0),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => AddUserScreen()),
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                ),
                                child: const Text(addNewUser),
                              ))
                        ]),
                        const SizedBox(height: 10),
                        ListView.builder(
                          itemCount: user.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(profileImage)
                              ),
                              title: Text(user[index].fullName),
                              subtitle: Text(user[index].email),
                              trailing: _manageUserIcon()
                            );
                          }
                        )
                      ]);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text("Something went wrong"));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
            )]
        )
      )
    );
  }

  // manage user : update and delete
  _manageUserIcon() => Row(
    children: [
      IconButton(
        icon: Icon(Icons.edit_square, color: Colors.black),
        onPressed: () {} // => Get.to(() => UpdateUserScreen())
      ),
      const SizedBox(width: 5),
      IconButton(
        icon: Icon(Icons.delete_forever_rounded, color: Colors.red),
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: Text('Delete User'),
              content: Text('Confirm to delete this user?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('No')
                ),
                ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () => {
                    setState( () {
                      //UserRepository.instance.deleteUserRecord(user);
                    }),
                    Navigator.pop(context),
                  },
                ),
              ],));
        },)
    ],);

}  
                           