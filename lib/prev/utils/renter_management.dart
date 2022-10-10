//add renter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../mvvm/models/response.dart';

import '../../mvvm/providers/current_home.dart';
import '../../mvvm/view_models/selected_flat_view_model.dart';
import '../../mvvm/services/renter_service.dart';
import '../providers/newrenter_step_provider.dart';

class RenterManagement {
  static Future<Response> addRenterToDatabase(BuildContext context) async {
    final provider = Provider.of<NewRenterStepProvider>(context, listen: false);
    final flat = context.read<SelectedFlatVuewModel>().selectedFlat;
    String homeId = Provider.of<CurrentHomeProvider>(context, listen: false)
        .currentHome!
        .homeId;
    double advanceAmount = provider.advanceController.text.isNotEmpty
        ? double.parse(provider.advanceController.text)
        : 0.00;
    Response response = await RenterService().addRenterToFlat(
      homeId: homeId,
      flatId: flat!.flatName,
      renterName: provider.renterNameController.text,
      phoneNo: provider.phoneController.text,
      alternatePhoneNo: provider.altPhoneController.text,
      occupation: provider.occupation,
      noOfPerson: provider.memberNo,
      entryDate: DateTime.now(),
      previousLocation: provider.previousLocationController.text,
      village: provider.villageController.text,
      policeStation: provider.thanaController.text,
      union: provider.unionController.text,
      subDistrict: provider.subDistrictController.text,
      district: provider.districtController.text,
      advance: advanceAmount,
    );

    return response;
  }
}
