import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/models/beauticians_model.dart';
import 'package:beautilly/screens/beautician_pages/schedule_appointment.dart';
import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart'; // Import the profile page
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FindService extends StatefulWidget {
  const FindService({super.key});

  @override
  State<FindService> createState() => _FindServiceState();
}

class _FindServiceState extends State<FindService> {
  final serviceData = ServiceData().serviceDataList;

  List<BeauticianModel> recommendedBeauticians = [];

  @override
  void initState() {
    super.initState();
    _fetchAndRecommendBeauticians();
  }

  Future<void> _fetchAndRecommendBeauticians() async {
    try {
      int? customerId = GlobalUser.customerId;

      if (customerId == null) {
        throw Exception("Customer ID is null");
      }

      Map<String, dynamic> preferences =
          await ApiService.getPreferences(customerId);
      List<Map<String, dynamic>> recommendations =
          await ApiService.getRecommendation(preferences);

      setState(() {
        recommendedBeauticians = recommendations
            .map((json) => BeauticianModel.fromJson(json))
            .take(3)
            .toList();
      });
    } catch (e) {
      print('Error fetching and recommending beauticians: $e');
      Fluttertoast.showToast(
        msg: "Failed to fetch recommendations.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideMenu(),
        body: SingleChildScrollView(
          // Scrollable container for vertical scrolling
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 15),
                const Text(
                  "What do you want to do?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111111)),
                ),
                const SizedBox(height: 20),
                _buildServiceGrid(),
                const SizedBox(height: 40),
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
            Text(
              "Hello, ${GlobalUser.firstName ?? 'User'}",
              style: const TextStyle(
                  color: Color(0xff111111),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Find the service you want, and treat yourself",
              style: TextStyle(
                  color: bGrey, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: bBlackColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
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

  Widget _buildBeauticianRecommendations() {
    if (recommendedBeauticians.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recommended Beauticians for You",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff111111)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendedBeauticians.length,
              itemBuilder: (context, index) {
                return _buildBeauticianCard(recommendedBeauticians[index]);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _buildBeauticianCard(BeauticianModel beautician) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleAppointment(
              beauticianId: beautician.beauticianId,
              salonId: beautician.salonId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with profile icon overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    beautician.imageUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: cardWidth,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StaffMemberProfile(
                            beauticianId: beautician.beauticianId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: bAccentLightColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: bAccentRedColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beautician.name,
                  style: const TextStyle(
                      fontSize: 16,
                      color: bBlackColor,
                      fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  "Gender: ${beautician.gender}",
                  style: TextStyle(
                    fontSize: 14,
                    color: bGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Salon: ${beautician.salonName}",
                  style: TextStyle(
                    fontSize: 14,
                    color: bGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),

                // Rating Row
                Row(
                  children: [
                    const Icon(Icons.star, color: bSecondaryColor, size: 15),
                    const SizedBox(width: 5),
                    Text(
                      beautician.score.toString(),
                      style: const TextStyle(
                          color: Color(0xff111111),
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildService(int index) {
    return GestureDetector(
      onTap: () {
        if (serviceData[index].destinationPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => serviceData[index].destinationPage),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Page not available")),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 74,
            height: 74,
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
            style: const TextStyle(
                fontSize: 14,
                color: bPrimaryColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
