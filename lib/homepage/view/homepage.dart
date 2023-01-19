import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkingadmin/homepage/view/add_parking_area.dart';
import 'package:parkingadmin/homepage/view/detail_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final parkingadd =
      FirebaseFirestore.instance.collection('Parking_Area_Collection');
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 80),
              ),
              Text(
                textAlign: TextAlign.center,
                'Home Page',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: .050.sw,
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 235, 219, 174),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(150),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddParkingArea(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: parkingadd
            .where('user_id', isEqualTo: auth.currentUser!.uid)
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
        ) {
          if (snapshot.hasData) {
            final parkinghome = snapshot.data!.docs;
            return SingleChildScrollView(
              child: GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 330,
                  childAspectRatio: 0.75,
                ),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (context) =>
                              DetailScreen(parkingAxis: parkinghome[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        margin: const EdgeInsets.only(top: 18, bottom: 30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                'assets/images/pngimg.com - parking_PNG91.png',
                                height: 100,
                                width: 200,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              parkinghome[index]['Area_Name'].toString(),
                              style: GoogleFonts.actor(fontSize: 17),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  height: 70,
                                  width: 15,
                                ),
                                const Icon(Icons.location_on_outlined),
                                Text(
                                  parkinghome[index]['Location_Name']
                                      .toString(),
                                  style: GoogleFonts.andadaPro(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
