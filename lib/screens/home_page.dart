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

  Map<String, dynamic>? recommendedBeautician;

  @override
  void initState() {
    super.initState();
    _fetchAndRecommendBeautician();
  }

  Future<void> _fetchAndRecommendBeautician() async {
    try {
      // Get customer ID from GlobalUser
      int? customerId = GlobalUser.customerId;

      if (customerId == null) {
        throw Exception("Customer ID is null");
      }

      // Fetch preferences
      Map<String, dynamic> preferences = await ApiService.getPreferences(customerId);

      // Send recommendation request
      Map<String, dynamic> recommendation = await ApiService.getRecommendation(preferences);

      // Update the state with the recommended beautician data
      setState(() {
        recommendedBeautician = recommendation;
      });
    } catch (e) {
      print('Error fetching and recommending beautician: $e');
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
                _buildBeauticianRecommendation(),
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

  Widget _buildBeauticianRecommendation() {
    if (recommendedBeautician == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Beautician for you",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff111111)),
          ),
          const SizedBox(height: 20),
          _buildBeauticianCard(),
        ],
      );
    }
  }

  Widget _buildBeauticianCard() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 200,
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    recommendedBeautician?['Image'] ?? '',
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                ),
                Container(
                  alignment: const Alignment(0.95, -0.95),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: bAccentLightColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: bAccentRedColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            recommendedBeautician?['Name'] ?? '',
            style: const TextStyle(fontSize: 16, color: bBlackColor, fontWeight: FontWeight.w600),
          ),
          Text(
            "Gender: ${recommendedBeautician?['Gender'] ?? ''}",
            style: TextStyle(fontSize: 14, color: bGrey, fontWeight: FontWeight.w500),
          ),
          Text(
            "Salon: ${recommendedBeautician?['Salon_Name'] ?? ''}",
            style: TextStyle(fontSize: 14, color: bGrey, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.star, color: bSecondaryColor, size: 15),
              const SizedBox(width: 5),
              Text(
                recommendedBeautician?['score']?.toString() ?? '',
                style: const TextStyle(color: Color(0xff111111), fontWeight: FontWeight.w600, fontSize: 12),
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
