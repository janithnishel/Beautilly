import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/screens/join_page.dart';
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/share_widget/share_custom_textield.dart';
import 'package:flutter/material.dart';

class FindService extends StatefulWidget {
  const FindService({super.key});

  @override
  State<FindService> createState() => _FindServiceState();
}

class _FindServiceState extends State<FindService> {
  final serviceData = ServiceData().serviceDataList;

  // Placeholder for the beautician recommendation data
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
                const SizedBox(height: 15),
                const Text(
                  "What do you want to do?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff111111)),
                ),
                const SizedBox(height: 20),
                _buildServiceGrid(),
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
            Text(
              "Hello, ${GlobalUser.firstName ?? 'User'}",  // Use the global variable
              style: const TextStyle(color: Color(0xff111111), fontSize: 24, fontWeight: FontWeight.w600),
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
}
