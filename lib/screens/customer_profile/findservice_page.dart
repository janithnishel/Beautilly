import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/models/beauticians_model.dart';
import 'package:beautilly/screens/beautician_pages/schedule_appointment.dart';
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

  // Placeholder for the beautician recommendations data
  List<BeauticianModel> recommendedBeauticians = [];

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

      // Convert the recommendations into a list of BeauticianModel
      setState(() {
        recommendedBeauticians = recommendations.map((json) => BeauticianModel.fromJson(json)).take(3).toList(); // Take only the first three recommendations
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
        drawer: SideMenu(), // Add the side menu here
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
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: bBlackColor),
            onPressed: () => Scaffold.of(context).openDrawer(), // Opens the side menu
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff111111)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300, // Adjust the height as needed
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
        width: 200,
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
                      beautician.imageUrl,
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
              beautician.name,
              style: const TextStyle(fontSize: 16, color: bBlackColor, fontWeight: FontWeight.w600),
            ),
            Text(
              "Gender: ${beautician.gender}",
              style: TextStyle(fontSize: 14, color: bGrey, fontWeight: FontWeight.w500),
            ),
            Text(
              "Salon: ${beautician.salonName}",
              style: TextStyle(fontSize: 14, color: bGrey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.star, color: bSecondaryColor, size: 15),
                const SizedBox(width: 5),
                Text(
                  beautician.score.toString(),
                  style: const TextStyle(color: Color(0xff111111), fontWeight: FontWeight.w600, fontSize: 12),
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
            MaterialPageRoute(builder: (context) => serviceData[index].destinationPage),
          );
        } else {
          // Optionally, show an error message or fallback widget
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Page not available")),
          );
        }
      },
      child: Column(
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
      ),
    );
  }
}
