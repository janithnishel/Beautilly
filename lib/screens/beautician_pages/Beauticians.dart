import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'add_review.dart'; // Import the AddReview page

class Beauticians extends StatefulWidget {
  const Beauticians({super.key});

  @override
  State<Beauticians> createState() => _BeauticiansState();
}

class _BeauticiansState extends State<Beauticians> {
  // List to hold beauticians data
  List<Map<String, dynamic>> beauticiansList = [];

  @override
  void initState() {
    super.initState();
    fetchBeauticiansData();
  }

  void fetchBeauticiansData() async {
    var data = await ApiService.getAllBeauticians();
    if (data != null) {
      setState(() {
        beauticiansList = data;
      });
    } else {
      print('Failed to retrieve beauticians.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Beauticians List",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111111),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Check if beauticiansList is not empty
                beauticiansList.isNotEmpty
                    ? ListView.builder(
                        itemCount: beauticiansList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddReview(
                                    beauticianId: beauticiansList[index]['Beautician_ID'],
                                  ),
                                ),
                              );
                            },
                            child: _buildBeauticianCard(index),
                          );
                        },
                      )
                    : Center(
                        child: const CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBeauticianCard(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        color: bWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: bhightLightGrey,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    beauticiansList[index]['Image'],
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        print(index);
                      });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: bAccentLightColor),
                      child: const Center(
                          child: Icon(
                        Icons.favorite,
                        color: bAccentRedColor,
                        size: 25,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beauticiansList[index]['Position'],
                      style: const TextStyle(
                          color: bPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      beauticiansList[index]['Name'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff111111),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Age: ${beauticiansList[index]['Age']}",
                      style: const TextStyle(
                          color: bDarkGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: bSecondaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          beauticiansList[index]['Rating_Score'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(
                              0xff111111,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          beauticiansList[index]['Characteristics'],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: bBlackColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
