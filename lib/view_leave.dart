import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewLeavePermission extends StatefulWidget {
  const ViewLeavePermission({Key? key}) : super(key: key);

  @override
  _ViewLeavePermissionState createState() => _ViewLeavePermissionState();
}

class _ViewLeavePermissionState extends State<ViewLeavePermission> {
  Future _data;
  //هذة الدالة تقوم بجلب البيانات من الفايربيز
  Future getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection("permission").get();
    return snapshot.docs;
  }

  @override
  initState() {
    //هذة الدالة تبدا في العمل مع بداية انشاء الصفحة
    //تقوم  الدالة جيت داتا بجلب البيانات من الفايربيز ثم تخزنها في الدالة الاسمها داتا
    _data = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Permission leave"),
      ),
      body: Column(
        children: [
          RefreshIndicator(
            onRefresh: getData,
            child: Container(
              width: double.infinity,
              height: size.height / 2.0,
              child: FutureBuilder(
                //هنا يتم جلب البيانات من الفايربيز ثم تخزينها في  اللستة وتعبئتها
                future: _data,
                builder: (_, snaphot) {
                  if (!snaphot.hasData || snaphot.data == null) {
                    return Center(child: Text("Loading..."));
                  } else if (snaphot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snaphot.data.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey[200],
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    //Reason هنا يتم عرص الحقل 
                                    "${snaphot.data[index]["Reason"]}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  trailing:
                                  //Date هنا يتم عرص الحقل 
                                      Text("${snaphot.data[index]["Date"]}"),
                                  leading:
                                  //Time هنا يتم عرص الحقل 
                                      Text("${snaphot.data[index]["Time"]}"),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Accept"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Reject"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text("Review"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
