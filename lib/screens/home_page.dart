import 'dart:math';
import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/data/get_offer_data.dart';
import 'package:beautilly/data/nearby_beautician._data.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/half_circle.dart';
import 'package:flutter/material.dart';
import 'package:beautilly/utils/GlobalUser.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final offerData = GetOfferData().getOfferListData;
  final serviceData = ServiceData().serviceDataList;
  final beautician = NearbyBeauticianData().nearbyBeauticianDataList;

  List<Map<String, dynamic>> recommendedBeauticians = [];

  @override
  void initState() {
    super.initState();
    _fetchAndRecommendBeauticians();
  }

 Future<void> _fetchAndRecommendBeauticians() async {
    try {
      // Get customer ID from GlobalUser
      int? customerId = GlobalUser.customerId;

      if (customerId == null) {
        throw Exception("Customer ID is null");
      }

      // Fetch preferences
      Map<String, dynamic> preferences = await ApiService.getPreferences(customerId);

      // Send recommendation request
      List<Map<String, dynamic>> recommendations = await ApiService.getRecommendation(preferences);

      // Update the state with the first three recommended beauticians
      setState(() {
        recommendedBeauticians = recommendations.take(3).toList(); // Take only the first three recommendations
      });
    } catch (e) {
      print('Error fetching and recommending beauticians: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildOfferCards(),
                const SizedBox(height: 15),
                const Text(
                  "What do you want to do?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff111111)),
                ),
                const SizedBox(height: 20),
                _buildServiceGrid(),
                const SizedBox(height: 20),
                const Text(
                  "Recommended Salon For you",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff111111)),
                ),
                const SizedBox(height: 20),
                _buildNearbySalons(),
                const SizedBox(height: 20),
                const Text(
                  "Recommended Beauticians for You",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff111111)),
                ),
                const SizedBox(height: 20),
                _buildBeauticianRecommendations(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Samantha",
              style: TextStyle(color: Color(0xff111111), fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text(
              "Find the service you want, and treat yourself",
              style: TextStyle(color: bGrey, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: bPrimaryColor, borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(Icons.search, color: bWhite, size: 30),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCards() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: offerData.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildOfferCard(index);
        },
      ),
    );
  }

  Widget _buildServiceGrid() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 205,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: serviceData.length,
        physics: const NeverScrollableScrollPhysics(),
        clipBehavior: Clip.hardEdge,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 6 / 8,
        ),
        itemBuilder: (context, index) {
          return _buildService(index);
        },
      ),
    );
  }

  Widget _buildNearbySalons() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: beautician.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: bPrimaryColor, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  beautician[index].inmageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBeauticianRecommendations() {
    if (recommendedBeauticians.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SizedBox(
        height: 300, // Adjust the height as needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendedBeauticians.length,
          itemBuilder: (context, index) {
            return _buildBeauticianCard(recommendedBeauticians[index]);
          },
        ),
      );
    }
  }

  Widget _buildBeauticianCard(Map<String, dynamic> beauticianData) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              beauticianData['Image'] ?? '',
              fit: BoxFit.cover,
              height: 150,
              width: 200,
            ),
          ),
          const SizedBox(height: 10),
          // Name
          Text(
            beauticianData['Name'] ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          // Gender
          Text(
            "Gender: ${beauticianData['Gender'] ?? ''}",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          // Salon Name
          Text(
            "Salon: ${beauticianData['Salon_Name'] ?? ''}",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          // Score
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                beauticianData['score']?.toString() ?? 'N/A',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildService(int index) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: bPrimaryLightColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Image.asset(
              serviceData[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          serviceData[index].title,
          style: const TextStyle(fontSize: 14, color: bPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildOfferCard(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    offerData[index].imageUrl,
                    fit: BoxFit.cover,
                    height: 120,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 30, right: 20, top: 16),
                  child: Text(
                    "Look more beautiful and \nsave more discount",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: bWhite,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 20,
                  bottom: 10,
                  child: Transform.rotate(
                    angle: -10 * pi / 180,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: bSecondaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Up to",
                            style: TextStyle(
                              fontSize: 14,
                              color: bWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            offerData[index].discount,
                            style: const TextStyle(
                              fontSize: 24,
                              color: bWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 30,
                  left: -20,
                  bottom: 30,
                  child: HalfCircle(
                    rotatinDirection: pi,
                  ),
                ),
                const Positioned(
                  top: 30,
                  right: -20,
                  bottom: 30,
                  child: HalfCircle(
                    rotatinDirection: -pi,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 150,
                  top: 80,
                  bottom: 10,
                  child: Container(
                    width: 150,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: bSecondaryLightColor,
                    ),
                    child: const Center(
                      child: Text(
                        "Get offer now!",
                        style: TextStyle(
                          color: bSecondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
