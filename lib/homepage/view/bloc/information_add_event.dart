part of 'information_add_bloc.dart';

@immutable
abstract class InformationAddEvent {}


class AddDetailEvent extends InformationAddEvent{
  AddDetailEvent({
    required this.image,
    required this.name,
    required this.description,
    required this.locationName,
    required this.facilities,
    required this.slots,
  });

  List<XFile?>? image;
  String name;
  String description;
  String locationName;
   String facilities;
   String slots;
}
