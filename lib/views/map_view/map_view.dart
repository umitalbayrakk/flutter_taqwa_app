import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/controllers/location_controller.dart';
import 'package:get/get.dart';

class LocationDebugView extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konum Test')),
      body: Obx(() {
        if (locationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (locationController.errorMessage.isNotEmpty) {
          return Center(child: Text(locationController.errorMessage.value));
        }

        final position = locationController.currentPosition.value;
        if (position == null) {
          return const Center(child: Text('Konum bilgisi yok.'));
        }

        return Center(
          child: Text(
            'Konum:\nLat: ${position.latitude},\nLng: ${position.longitude}',
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}
