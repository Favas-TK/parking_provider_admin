import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'information_add_event.dart';
part 'information_add_state.dart';

class InformationAddBloc
    extends Bloc<InformationAddEvent, InformationAddState> {
  InformationAddBloc() : super(InformationAddInitial()) {
    on<InformationAddEvent>((event, emit) async {
      if (event is AddDetailEvent) {
        try {
          final auth = FirebaseAuth.instance;
          final parkingAdd =
              FirebaseFirestore.instance.collection('Parking_Area_Collection');

          final userId = auth.currentUser!.uid;

          const uuid = Uuid();
          final parkingId = uuid.v4();
          final images = event.image;
          final imageList = [];
          for (final image in images!) {
            final reference = FirebaseStorage.instance
                .ref()
                .child('Spot_image')
                .child(image!.path);
            final file = File(image.path);
            await reference.putFile(file);
            final imagelink = await reference.getDownloadURL();
            imageList.add(imagelink);
          }

          await parkingAdd.doc(parkingId).set({
            'Area_Name': event.name,
            'Location_Name': event.locationName,
            'Information': event.description,
            'Facilities': event.description,
            'Spot_image': imageList,
            'user_id': userId,
          });
          emit(DetailsAddSucess());
        } catch (e) {
          emit(DetailsAddFiled());
        }
      }
    });
  }
}
