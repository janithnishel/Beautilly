import 'dart:math';

import 'package:beautilly/data/beauticians%20data.dart';
import 'package:beautilly/data/get_offer_data.dart';
import 'package:beautilly/data/nearby_beautician._data.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/half_circle.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //feth offer card details
  final offerData = GetOfferData().getOfferListData;

  //fetch the service data from servicedata data class
  final serviceData = ServiceData().serviceDataList;

  //fetch the beauticians data from  BeauticiansData class
  final beauticiansData = BeauticiansData().beauticiansDataList;

  //fetch the beauticians data from  BeauticiansData class
  final beautician = NearbyBeauticianData().nearbyBeauticianDataList;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello, Samantha",
                          style: TextStyle(
                            color: Color(0xff111111),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Find the service you want, and treat yourself",
                          style: TextStyle(
                            color: bGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: bPrimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: bWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 120,
                  // width: MediaQuery.of(context).size.width*0.6,
                  child: ListView.builder(
                    itemCount: offerData.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _buildOfferCard(index);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "What do you want to do?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111111)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 205,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: serviceData.length,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 6 / 8,
                    ),
                    itemBuilder: (context, index) {
                      return _buildService(index);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Recommended Saloon For you",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111111)),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
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
                            border: Border.all(color: bPrimaryColor, width: 2)),
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Text(
                        "Recommended Beautician for you",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff111111)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: bPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.43,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: beauticiansData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _buildBeauticianCard(index);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//build the one sevice of salon
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
        const SizedBox(
          height: 10,
        ),
        Text(
          serviceData[index].title,
          style: const TextStyle(
            fontSize: 14,
            color: bPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // build  single Beautician details card

  Widget _buildBeauticianCard(int index) {
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
            child: Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      beauticiansData[index].imageUrl,
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
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                beauticiansData[index].service[0],
                style: const TextStyle(color: bPrimaryColor, fontSize: 12),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                beauticiansData[index].service[1],
                style: const TextStyle(color: bPrimaryColor, fontSize: 12),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                beauticiansData[index].service[2],
                style: const TextStyle(color: bPrimaryColor, fontSize: 12),
              ),
            ],
          ),
          Text(
            beauticiansData[index].name,
            style: const TextStyle(
              fontSize: 16,
              color: bBlackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            beauticiansData[index].address,
            style: TextStyle(
                fontSize: 14,
                color: bGrey,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: bSecondaryColor,
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                beauticiansData[index].rateScore.toString(),
                style: const TextStyle(
                    color: Color(0xff111111),
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "(${beauticiansData[index].ratedCount})",
                style: const TextStyle(color: Color(0xff111111), fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOfferCard(int index) {
    return Container(
      margin: EdgeInsets.only(right: 10),
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
                    // width: MediaQuery.of(context).size.width,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    bottom: 30,
                    right: 20,
                    top: 16,
                  ),
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
                          )
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
                        color: bSecondaryLightColor),
                    child: const Center(
                        child: Text(
                      "Get offer now!",
                      style: TextStyle(
                        color: bSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
