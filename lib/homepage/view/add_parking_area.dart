import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkingadmin/homepage/view/bloc/information_add_bloc.dart';
import 'package:parkingadmin/homepage/view/homepage.dart';

class AddParkingArea extends StatefulWidget {
  const AddParkingArea({super.key});

  @override
  State<AddParkingArea> createState() => _AddParkingAreaState();
}

class _AddParkingAreaState extends State<AddParkingArea> {
  late final XFile? image;

  final parkingAdd =
      FirebaseFirestore.instance.collection('Parking_Area_Collection');

  final auth = FirebaseAuth.instance;

  final parkingDetails = InformationAddBloc();

  TextEditingController parkingAreaName = TextEditingController();

  TextEditingController parkingLocation = TextEditingController();

  TextEditingController parkingInformation = TextEditingController();

  TextEditingController parkingFacilities = TextEditingController();
  List<XFile?>? imagefiles;

  final imgpicker = ImagePicker();

  Future<List<XFile>>? pickedfiles;

  Future<void> openImages() async {
    try {
      pickedfiles = imgpicker.pickMultiImage();
      if (pickedfiles != null) {
        imagefiles = await pickedfiles;
        setState(() {});
      } else {
        // print('No image is selected.');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => parkingDetails,
      child: BlocListener<InformationAddBloc, InformationAddState>(
        listener: (context, state) {
          if (state is DetailsAddSucess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sucessfully added'),
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (context) => const HomePage(),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Add Parking Area',
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
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      child: Text('Upload Images'),
                      onPressed: openImages,
                    ),
                    FutureBuilder<List<XFile>>(
                      future: pickedfiles,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final images = snapshot.data;
                          return Container(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: images!.length,
                              itemBuilder: (context, index) {
                                return Image.file(
                                  File(images[index].path),
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 500,
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: parkingAreaName,
                        decoration: InputDecoration(
                          labelText: 'Enter Parking Area Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-z]+$').hasMatch(value)) {
                            return 'Enter correct Parking Area';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: parkingLocation,
                        decoration: InputDecoration(
                          labelText: 'Enter Parking Location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[A-z]+$').hasMatch(value)) {
                            return 'Enter Parking Location';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: parkingInformation,
                        decoration: InputDecoration(
                          labelText: 'Enter Information of Area',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: parkingFacilities,
                        decoration: InputDecoration(
                          labelText: 'Enter Facilites Provided',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      //height: 150.h,
                      width: 300.w,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 50,
                          // child: BtnWdgt(
                          //   textClr: Colors.white,
                          //   name: 'Submit',
                          //   raduis: 30,
                          //   clr: Color.fromARGB(255, 31, 73, 107),
                          // ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            highlightElevation: 0,
                            textColor: Colors.white,
                            color: const Color.fromARGB(255, 235, 219, 174),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              parkingDetails.add(
                                AddDetailEvent(
                                    image: imagefiles,
                                    name: parkingAreaName.text,
                                    description: parkingInformation.text,
                                    locationName: parkingLocation.text,
                                    facilities: parkingFacilities.text),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
