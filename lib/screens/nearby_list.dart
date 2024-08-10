import 'package:beautilly/data/nearby_saloon._data.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class NearbyList extends StatefulWidget {
  const NearbyList({super.key});

  @override
  State<NearbyList> createState() => _NearbyListState();
}

class _NearbyListState extends State<NearbyList> {
  // fetching service data from Srvice data model
  final serviceData = ServiceData().serviceDataList;

  //fetch the nearby salon data

  final nearbySaloonData = NearbySaloonData().nearbySaloonDataList;

  // fetching the index
  int indexNo = 0;
  final List<int> clickButton = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nearby Salon List",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff111111),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: serviceData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          indexNo = index;
                          clickButton.add(indexNo);
                          print(indexNo);
                          print(clickButton);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomButton(
                          title: serviceData[index].title,
                          isHasMultipleWidget: false,
                          width: 100,
                          borderColor: bPrimaryColor,
                          color: bPrimaryLightColor,
                          textColor: bPrimaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //
              _buildSaloonCard(0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaloonCard(int index) {
    return Container(
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
                  child: Image.asset(
                    nearbySaloonData[index].imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12),
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
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    width: 65,
                    height: 35,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: bSecondaryLightColor,
                    ),
                    child: Center(
                      child: Text(
                        nearbySaloonData[index].distance,
                        style: TextStyle(
                          color: bSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
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
                    const Text("Hair,Facial"),
                    const SizedBox(height: 5),
                    Text(
                      nearbySaloonData[index].salonName,
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
                      nearbySaloonData[index].address,
                      style: const TextStyle(
                          color: bDarkGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: bSecondaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          nearbySaloonData[index].rateScore.toString(),
                          style: TextStyle(
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
                          "(${nearbySaloonData[index].ratedCount})",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: bBlackColor,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/Base.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "-58%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xff111111,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     color: Colors.amber,
          //     decoration: BoxDecoration(
          //       borderRadius:BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: )              ),
          //   ),
          // ),
          // Expanded(
          //   flex: 4,
          //   child: Container(
          //     color: Colors.blue,
          //   ),
          // ),
        ],
      ),
    );
  }
}
