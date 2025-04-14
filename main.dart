import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Data Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _statusMessage = '';

  Future<void> addUserData(String name, int age) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'age': age,
      });
      setState(() {
        _statusMessage = 'User Added Successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to add user: $e';
      });
    }
  }

  Stream<QuerySnapshot> getUserData() {
    return _firestore.collection('users').snapshots();
  }

  Future<void> updateUserData(String userId, String name, int age) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': name,
        'age': age,
      });
      setState(() {
        _statusMessage = 'User Updated Successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to update user: $e';
      });
    }
  }

  Future<void> deleteUserData(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      setState(() {
        _statusMessage = 'User Deleted Successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to delete user: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Data Control')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                int age = int.tryParse(_ageController.text) ?? 0;
                if (name.isNotEmpty && age > 0) {
                  addUserData(name, age);
                  _nameController.clear();
                  _ageController.clear();
                }
              },
              child: Text('Add User'),
            ),
            SizedBox(height: 20),
            Text(_statusMessage, style: TextStyle(fontSize: 16, color: Colors.green)),
            SizedBox(height: 20),
            Text('User List:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No users found.'));
                  }

                  final users = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      String userId = user.id;
                      String name = user['name'];
                      int age = user['age'];

                      return Card(
                        child: ListTile(
                          title: Text('$name, Age: $age'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _nameController.text = name;
                                  _ageController.text = age.toString();
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Update User'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(labelText: 'Name'),
                                          ),
                                          TextField(
                                            controller: _ageController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(labelText: 'Age'),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            String updatedName = _nameController.text;
                                            int updatedAge = int.tryParse(_ageController.text) ?? age;
                                            if (updatedName.isNotEmpty && updatedAge > 0) {
                                              updateUserData(userId, updatedName, updatedAge);
                                              Navigator.pop(context);
                                              _nameController.clear();
                                              _ageController.clear();
                                            }
                                          },
                                          child: Text('Update'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteUserData(userId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
