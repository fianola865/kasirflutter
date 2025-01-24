import 'package:flutter/material.dart';
import 'package:kasir/admin/regristrasi/insertuser.dart';
import 'package:kasir/admin/regristrasi/updateuser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserTab extends StatefulWidget {
  const UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  List<Map<String, dynamic>> user = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchuser();
  }
  Future<void> deleteuser(int id) async{
    try{
      await Supabase.instance.client.from('user').delete().eq('Userid', id);
      fetchuser();
    } catch (e){
      print('error: $e');
    }
  }
  Future<void> fetchuser() async{
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Supabase.instance.client.from('user').select();
      setState(() {
        user = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      print('error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User table'),
      ),
      body: isLoading
      ? Center(
        child: LoadingAnimationWidget.twoRotatingArc(color: Colors.grey, size: 30),
      )
      : user.isEmpty
      ? Center(
        child: Text('User belum ditambahkan',
        style: TextStyle(fontSize: 18),
        ),
      )
      : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Username',
              style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
            DataColumn(
              label: Text('Password',
              style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
            DataColumn(
              label: Text('Role',
              style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
            DataColumn(
              label: Text('Aksi',
              style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
            DataColumn(
              label: Text('Tambah',
              style: TextStyle(fontWeight: FontWeight.bold),
              )
            ),
          ], 
          rows: 
          user
          .map(
            (userdata) => DataRow(
              cells: [
                DataCell(Text(userdata['Username'] ?? '')),
                DataCell(Text(userdata['Password'] ?? '')),
                DataCell(Text(userdata['Role'] ?? '')),
                DataCell(
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        final Userid = userdata['Userid'] ?? 0;
                        if(Userid != 0);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUser(Userid: Userid)));
                      }, icon: Icon(Icons.edit,color: Colors.blue)),
                      SizedBox(width: 16),
                      IconButton(onPressed: (){
                        showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Hapus user'),
                            content: Text('Apakah anda yakin menghapus user?'),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('Batal')),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                                deleteuser(userdata['Userid']);
                              }, 
                              child: Text('Hapus'))
                            ],
                          );
                        });
                      }, icon: Icon(Icons.delete, color: Colors.red))
                    ],
                  )
                ),
                DataCell(IconButton(onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => UserInsert())
                        );
                      }, icon: Icon(Icons.add)),)
              ]
            )
          )
          .toList()
        )
      )
    );
  }
}