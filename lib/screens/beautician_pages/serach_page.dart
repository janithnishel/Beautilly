import 'package:beautilly/data/nearby_saloon._data.dart';
import 'package:beautilly/data/service_data.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:beautilly/widget/custom_textform_field.dart';
import 'package:beautilly/widget/share_widget/share_custom_textield.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // fetching service data from Srvice data model
  final serviceData = ServiceData().serviceDataList;
  //fetch the nearby salon data
  final nearbySaloonData = NearbySaloonData().nearbySaloonDataList;

  // fetching the index
  int indexNo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bWhite,
        centerTitle: true,
        elevation: 0.5,
        actions: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/filter.png",
                  fit: BoxFit.cover, width: 20, height: 5))
        ],
        title: const Text(
          "Search",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: bBlackColor,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: bPrimaryColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomTextField(
              isHasHintText: true,
              isHasPrefixIcon: true,
              isHasssuffixIcon: false,
              enableBorderRadius: 50,
              foccusBorderRadius: 50,
              hintText: "Search salon or service..",
              hintTextColor: Color(0xffADB3BC),
              fillColor: Color(0xffF0F3F6),
              prefixIcon: Icon(
                Icons.search,
                size: 30,
                color: bPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recents",
                  style: TextStyle(
                    color: Color(0xffADB3BC),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Clear all",
                  style: TextStyle(
                    color: bPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height * 0.15,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _recentSearchBar("Hair service"),
                  _recentSearchBar("Nail"),
                  _recentSearchBar("Wax"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Popular Search",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: bBlackColor),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                itemCount: serviceData.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3 / 1,
                  // mainAxisExtent: 30,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomButton(
                      title: serviceData[index].title,
                      isHasMultipleWidget: false,
                      color: bPrimaryLightColor,
                      textColor: bPrimaryColor,
                    ),
                  );
                },
              ),
            ),
            const Text(
              "Suggestion for you",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: bBlackColor),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              itemCount: nearbySaloonData.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildSaloonCard(index);
              },
            )
          ]),
        ),
      ),
    );
  }

  //create a single saloon card view

  Widget _buildSaloonCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        indexNo = index;
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
                        style: const TextStyle(
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
                    const Text(
                      "Hair . Facial",
                      style: TextStyle(
                          color: bPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      nearbySaloonData[index].salonName,
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
                      nearbySaloonData[index].address,
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
                          nearbySaloonData[index].rateScore.toString(),
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
                          "(${nearbySaloonData[index].ratedCount})",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: bBlackColor,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "assets/images/mask.png",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
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
        ],
      ),
    );
  }

// create the single recentSearch bar
  Widget _recentSearchBar(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: CustomBox(
        widget:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: bBlackColor,
                ),
              ),
              Icon(
                Icons.close,
                size: 15,
                color: bPrimaryColor,
              )
            ],
          ),
        ),
        isHaSBorder: false,
        blurRadius: 4,
        shadowOfset: const Offset(0, 2),
        color: bWhite,
        width: MediaQuery.of(context).size.width,
        height: 50,
        borderRadius: 5,
      ),
    );
  }
}
