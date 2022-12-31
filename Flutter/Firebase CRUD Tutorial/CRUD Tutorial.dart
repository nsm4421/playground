import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var users = [];
  late DatabaseReference ref;
  late TextEditingController idCtrl;
  late TextEditingController pwCtrl;
  late TextEditingController nicknameCtrl;

  void addUser () async{
    Map data = {
      "id" : idCtrl.value.text,
      "pw" : pwCtrl.value.text,
      "nickname" : nicknameCtrl.value.text
    };
    idCtrl.clear();
    pwCtrl.clear();
    nicknameCtrl.clear();
    DatabaseReference childRef = ref.child('user').push();
    await childRef
        .set(data)
        .then((_)=>{
          setState((){
            users.add(data);
          })
    });
  }

  void getUsers() async {
    final snapshot = await ref.child('user').get();
    if ((users.length == 0) & (snapshot.exists)){

        Map<String, dynamic> data = snapshot.value as Map<String, dynamic>;
        setState(() {
          data.forEach((key, value) {
            value['key'] = key;
            users.add(value);
          });
        });
      }
  }

  void deleteUser(String uid, int idx) async{
    await ref.child('user/${uid}')
        .remove()
        .then((_){
          setState(() {
            users.removeAt(idx);
          });
    });
  }

  @override
  initState(){
    ref = FirebaseDatabase.instance.ref();
    idCtrl = TextEditingController();
    pwCtrl = TextEditingController();
    nicknameCtrl = TextEditingController();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home : Scaffold(
            appBar: AppBar(title: Text("Firebase Tutorial"),),
            body : Column(
              children: <Widget>[
                Text("Real Time Database"),
                // 아이디
                TextField(
                  controller: idCtrl,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "ID",
                    border: OutlineInputBorder(),
                  ),
                ),
                // 비밀번호
                TextField(
                  controller: pwCtrl,
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "PW",
                    border: OutlineInputBorder(),
                  ),
                ),
                // 닉네임
                TextField(
                  controller: nicknameCtrl,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nickname",
                    border: OutlineInputBorder(),
                  ),
                ),
                // 제출버튼
                FlatButton(
                    onPressed: (){
                      addUser();
                    },
                    child: Text("Submit")),

                Expanded(
                  child : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: Icon(Icons.account_box),
                          title : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("ID  ", style: TextStyle(fontWeight: FontWeight.w600),),
                                      Text("${users[index]['id']}",),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("PW  ", style: TextStyle(fontWeight: FontWeight.w600),),
                                      Text("${users[index]['pw']}"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Nickname  ", style: TextStyle(fontWeight: FontWeight.w600),),
                                      Text("${users[index]['nickname']}"),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(onPressed: (){
                                deleteUser(users[index]['key'], index);
                              }, icon: Icon(Icons.delete))
                            ],
                          )
                        );
                      }
                  )
                )

              ],
            )
        )
    );
  }
}
