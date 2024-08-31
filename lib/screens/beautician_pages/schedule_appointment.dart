import 'package:beautilly/screens/beautician_pages/appbar.dart/appbar.dart';
import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ScheduleAppointment extends StatefulWidget {
  const ScheduleAppointment({super.key});

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {



  //initialize the index to the each tapped button

 int  _onTap = 99;
  //appoinment times

  final List<String> appoinmentTimes = [
    "Tue, 26 Oct - 11:00 AM",
    "Mon, 25 Oct - 10:00 AM"
  ];

  // shedule times

  final List<String> scheduleTime = [
    "10:00 AM",
    "11:00 AM",
    "2:00 PM",
    "3:00 PM"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bWhite,
      appBar: appBar("Schedule Appointment",context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Date",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: bBlackColor),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Available on",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: bBlackColor),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select Time",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: bBlackColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < 4; i++)
                  GestureDetector(  // check whether the button clicked
                    onTap: () {
                      
                    setState(() {
                      
                       _onTap =i;



                    });


                    },
                    child: Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                          color: _onTap==i?bPrimaryColor: bLowLightGrey,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          scheduleTime[i],
                          style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _onTap==i ?bWhite:bBlackColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomButton(
              title: "Submit",
              isHasMultipleWidget: false,
              fontWeight: FontWeight.w500,
              textColor: bWhite,
              radius: 8,
              color: bBlackColor,
              borderColor: bBlackColor,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Scheduled Appointments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: bBlackColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              itemCount: appoinmentTimes.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return _appointmentCard(index);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _appointmentCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomBox(
          blurRadius: 1,
          shadowOfset: const Offset(0, 2),
          shadowColor: bhightLightGrey,
          height: 60,
          borderRadius: 5,
          color: bWhite,
          width: MediaQuery.of(context).size.width,
          widget: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.date_range_sharp,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Appoint #",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: bBlackColor),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      appoinmentTimes[index],
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: bBlackColor),
                    )
                  ],
                )
              ],
            ),
          ),
          isHaSBorder: false),
    );
  }
}
