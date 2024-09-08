import 'package:beautilly/data/beauticians%20data.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/share_widget/share_custom_textield.dart';
import 'package:flutter/material.dart';

class FindService extends StatefulWidget {
  const FindService({super.key});

  @override
  State<FindService> createState() => _FindServiceState();
}

class _FindServiceState extends State<FindService> {
  //fetch the service data from servicedata data class
  final serviceData = ServiceData().serviceDataList;

  //fetch thebeauticians data from  BeauticiansData class
  final beauticiansData = BeauticiansData().beauticiansDataList;

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
                  // height: MediaQuery.of(context).size.height * 0.34,
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
                  "Enter your Location ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomTextField(
                      isHasHintText: false,
                      isHasPrefixIcon: false,
                      isHasssuffixIcon: false,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: bPrimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search_sharp,
                          color: bWhite,
                          size: 25,
                        ),
                      ),
                    )
                  ],
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
                        "Recommended Nearby Beauticians",
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
          Container(
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
}

