import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';

class NearbyBeauticianSalon extends StatefulWidget {
  const NearbyBeauticianSalon({Key? key}) : super(key: key);

  @override
  State<NearbyBeauticianSalon> createState() => _NearbyBeauticianSalonState();
}

class _NearbyBeauticianSalonState extends State<NearbyBeauticianSalon> {
  Future<List<Map<String, dynamic>>>? nearbySalons;

  @override
  void initState() {
    super.initState();
    requestLocationPermission().then((_) {
      setState(() {
        nearbySalons = ApiService.getNearbySalons(); // Initialize after permissions are granted
      });
    }).catchError((error) {
      // Handle error if permissions are denied or another error occurs
      print('Error obtaining permission: $error');
    });
  }

  // Location permissions request method
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      print(statuses[Permission.location]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        titleSpacing: -15,
        elevation: 1,
        title: const Text(
          "Nearby Salons",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: bBlackColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  "https://via.placeholder.com/150",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Recommended Nearby Salons",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: nearbySalons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('No nearby salons found'));
                  }
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final salon = snapshot.data![index];
                      return _buildSalonCard(salon);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalonCard(Map<String, dynamic> salon) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch elements horizontally
        children: [
          Expanded(
            child: Image.network(
              salon['imageUrl'] ?? "https://via.placeholder.com/150",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  salon['Name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("Rating: ${salon['Rating_score']} Stars"),
                Text("Services: ${salon['Services']}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
