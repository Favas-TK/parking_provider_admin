import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingadmin/homepage/view/add_parking_area.dart';
import 'package:parkingadmin/homepage/widgets/facilities.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 635.h,
            width: 375.w,
            child: Column(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/OIP.HhQwBlSw5S3JURg2BWGZZgHaLy?pid=ImgDet&rs=1',
                        ),
                      ),
                    ),
                    Text(
                      'HILITE BUISNESS PARK',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Center(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 250.h,
                    ),
                    items: [
                      //  parkingdata['Spot_image'][0].toString(),
                      'https://th.bing.com/th/id/OIP.HhQwBlSw5S3JURg2BWGZZgHaLy?pid=ImgDet&rs=1',
                      'https://th.bing.com/th/id/OIP.HhQwBlSw5S3JURg2BWGZZgHaLy?pid=ImgDet&rs=1',
                      'https://th.bing.com/th/id/OIP.HhQwBlSw5S3JURg2BWGZZgHaLy?pid=ImgDet&rs=1',
                    ].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            height: 240.sh,
                            width: 300.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Image.network(i),
                                // Text('text $i', style: TextStyle(fontSize: 16.0),
                                // ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'hilite business park',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: const [
                      Icon(Icons.location_on_outlined, size: 18),
                      Text(
                        'kozhikode',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold,),
                      ),
                    ],
                  ),
                  trailing: const Text('30 slots'),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(right: 230.h),
                  child: const Text(
                    'Information',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50.h,
                  width: 300.h,
                  child: const Text(' parkdetail [].toString(),,'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 160.h),
                  child: const Text(
                    'Facilitities We Provide',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Facilities(),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        //   height: 50,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),),
                          highlightElevation: 0,
                          textColor: Colors.white,
                          color: const Color.fromARGB(255, 235, 219, 174),
                          child: const Text(
                            'Edit Page',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        //   height: 50,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),),
                          highlightElevation: 0,
                          textColor: Colors.white,
                          color: const Color.fromARGB(255, 235, 219, 174),
                          child: const Text(
                            'Delete Page',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
