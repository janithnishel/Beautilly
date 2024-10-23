import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class StaffMemberProfile extends StatefulWidget {
  final int beauticianId;

  const StaffMemberProfile({super.key, required this.beauticianId});

  @override
  State<StaffMemberProfile> createState() => _StaffMemberProfileState();
}

class _StaffMemberProfileState extends State<StaffMemberProfile> {
  late Future<Map<String, dynamic>> beauticianDetails;
  late Future<List<Map<String, dynamic>>> reviews; // Future to hold reviews

  @override
  void initState() {
    super.initState();
    beauticianDetails = ApiService.getBeauticianDetails(widget.beauticianId);
    reviews = ApiService.getReviewsByBeautician(widget.beauticianId); // Fetch reviews
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bWhite,
      appBar: AppBar(
        backgroundColor: bWhite,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            size: 20,
            color: bBlackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 3,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: beauticianDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final beautician = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildBeauticianHeader(beautician),
                    const SizedBox(height: 30),
                    const Text(
                      "Reviews",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: bBlackColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildReviews(), // Widget to build reviews
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBeauticianHeader(Map<String, dynamic> beautician) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: bhightLightGrey),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              beautician['Image'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              beautician['Name'],
              style: const TextStyle(
                color: bBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              beautician['Position'],
              style: const TextStyle(
                color: bBlackColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "Gender",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: bBlackColor,
              ),
            ),
            Text(
              beautician['Gender'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: bBlackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: reviews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No reviews found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final review = snapshot.data![index];
              return _buildReviewCard(review);
            },
          );
        }
      },
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review['Name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                review['Comment'],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  review['Image'],
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
