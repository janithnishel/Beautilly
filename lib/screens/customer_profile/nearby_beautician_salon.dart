import 'package:beautilly/data/nearby_beautician._data.dart';
import 'package:beautilly/data/nearby_saloon._data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:flutter/material.dart';

class NearbyBeauticianSalon extends StatefulWidget {
  const NearbyBeauticianSalon({super.key});

  @override
  State<NearbyBeauticianSalon> createState() => _NearbyBeauticianSalonState();
}

class _NearbyBeauticianSalonState extends State<NearbyBeauticianSalon> {
  // fetch nearby saloon data
  final saloonData = NearbySaloonData().nearbySaloonDataList;

  // fetch the nearby beautician data
  final beauticianData = NearbyBeauticianData().nearbyBeauticianDataList;

  bool isTap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        titleSpacing: -15,
        elevation: 1,
        title: const Text(
          "Nearby Beauticians and Salons",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: bBlackColor,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: bBlackColor,
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
                  "https://th.bing.com/th/id/R.64dbf9d2ca128a1b2b8cbe781874fb1e?rik=lP7GEkO76xzOQA&riu=http%3a%2f%2fcdn.wccftech.com%2fwp-content%2fuploads%2f2017%2f03%2fGoogle-Maps.jpg&ehk=xcHOr5BQ%2b6aPyq162KQL96IhP1d6RiHUqhGvH5Zu7xg%3d&risl=&pid=ImgRaw&r=0",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          // indexNo == 0;
                          isTap = true;
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 85,
                      decoration: BoxDecoration(
                          color: isTap ? bGrey.withOpacity(0.3) : bWhite,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: bBlackColor.withOpacity(0.1), width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "assets/images/salon.png",
                              fit: BoxFit.cover,
                              width: 48,
                              height: 40,
                            ),
                            const Text(
                              "Salon",
                              style: TextStyle(
                                color: bBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          isTap = false;
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 85,
                      decoration: BoxDecoration(
                        color: isTap ? bWhite : bGrey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: bBlackColor.withOpacity(0.1), width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/beautician.png",
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Beautician",
                            style: TextStyle(
                              color: bBlackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: const TextStyle(color: bBlackColor),
                cursorColor: bPrimaryColor,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Container(
                      width: 50,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: bBlackColor,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: bWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  hintText:
                      isTap ? "Search for Saloon" : "Search for Beautician",
                  hintStyle: TextStyle(
                    color: bGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: bhightLightGrey,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: bhightLightGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                isTap
                    ? "Recommended Nearby Salons"
                    : "Recommended Nearby Beautician",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),

              // _buildRecommendedDetailsCard(1),

              GridView.builder(
                itemCount: isTap ? saloonData.length : beauticianData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 8),
                itemBuilder: (context, index) {
                  return _buildRecommendedDetailsCard(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedDetailsCard(int index) {
    return Container(
      width: 175,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bWhite,
        border: Border.all(width: 1, color: bhightLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 175,
            decoration: BoxDecoration(
              color: bLowLightGrey,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    isTap
                        ? saloonData[index].imageUrl
                        : beauticianData[index].inmageUrl,
                    fit: BoxFit.cover,
                    height: 175,
                  ),
                ),
                Container(
                  width: 75,
                  height: 25,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                          10,
                        ),
                        bottomRight: Radius.circular(10),
                      ),
                      color: bGrey),
                  child: Center(
                    child: Text(
                      isTap
                          ? "${saloonData[index].rateScore} Stars"
                          : "${beauticianData[index].rateScore} Stars",
                      style: const TextStyle(
                          color: bWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                
                  isTap
                      ? saloonData[index].salonName
                      : beauticianData[index].beauticianName,
                  style: const TextStyle(
                    color: bBlackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  isTap
                      ? "Distance: ${saloonData[index].distance}"
                      : "Distance: ${beauticianData[index].distance}",
                  style: const TextStyle(
                    color: bBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
