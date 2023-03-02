import 'package:flutter/material.dart';

import '../models/random_user_model.dart';
import '../service/random_user_service.dart';

class RandomUserPage extends StatefulWidget {
  const RandomUserPage({super.key});

  @override
  State<RandomUserPage> createState() => _RandomUserPageState();
}

class _RandomUserPageState extends State<RandomUserPage> {
  String name = "Lucas";
  String email = "lucas@random.com";
  String image = "https://randomuser.me/api/portraits/thumb/men/1.jpg";
  RandomUser? data;

  void handleGetRandomUser() async {
    final response = await getRandomUser();

    setState(() => data = response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.94),
      appBar: barraSuperior(),
      body: corpo(),
    );
  }

  barraSuperior() {
    return AppBar(
      title: const Text("Random User"),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(100),
        ),
      ),
    );
  }

  corpo() {
    return Column(
      children: [cardUser()],
    );
  }

  cardUser() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Card(
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: data != null
                        ? ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                data!.results[0].picture.thumbnail,
                              ),
                            ),
                            title: Text(data!.results[0].name.first),
                            subtitle: Text(data!.results[0].email),
                          )
                        : ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(image),
                            ),
                            title: Text(name),
                            subtitle: Text(email),
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          botaoAtualizaUser(),
        ],
      ),
    );
  }

  botaoAtualizaUser() {
    return Container(
      padding: const EdgeInsets.only(),
      child: ElevatedButton.icon(
        icon: Icon(Icons.login_rounded),
        onPressed: () => handleGetRandomUser(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: const StadiumBorder(),
        ),
        label: Text(
          "Generate random user",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
