import 'package:beautilly/api/apiservice.dart';
import 'package:beautilly/screens/beautician_pages/appbar.dart/appbar.dart';
import 'package:beautilly/utils/GlobalUser.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:beautilly/widget/custom_box.dart';
import 'package:beautilly/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScheduleAppointment extends StatefulWidget {
  final int beauticianId;
  final int salonId;

  const ScheduleAppointment({
    super.key,
    required this.beauticianId,
    required this.salonId,
  });

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  // Selected date and time
  String? selectedDate;
  String? selectedTime;

  Future<void> _submitAppointment() async {
    try {
      // Get customer ID from GlobalUser
      int? customerId = GlobalUser.customerId;

      if (customerId == null) {
        throw Exception("Customer ID is null");
      }

      // Prepare the appointment data
      Map<String, dynamic> appointmentData = {
        "Date": selectedDate ?? "",
        "Time": selectedTime ?? "",
        "Status": "unknown", // Set Status to unknown
        "Customer_ID": customerId,
        "Beautician_ID": widget.beauticianId,
        "Salon_ID": widget.salonId,
      };

      // Send the appointment request
      await ApiService.postAppointment(appointmentData);

      // Show a toast message upon successful submission
      Fluttertoast.showToast(
        msg: "Appointment submitted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navigate back or to another page after submission
      Navigator.pop(context);
    } catch (e) {
      print('Error submitting appointment: $e');
      Fluttertoast.showToast(
        msg: "Failed to submit appointment.",
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
    return Scaffold(
      backgroundColor: bWhite,
      appBar: appBar("Schedule Appointment", context),
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
                color: bBlackColor,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: bLowLightGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate ?? "Pick a Date",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: bBlackColor,
                      ),
                    ),
                    const Icon(Icons.calendar_today, color: bBlackColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Select Time",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: bBlackColor,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  final now = DateTime.now();
                  final selectedDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  setState(() {
                    selectedTime = DateFormat('HH:mm').format(selectedDateTime);
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: bLowLightGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime ?? "Pick a Time",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: bBlackColor,
                      ),
                    ),
                    const Icon(Icons.access_time, color: bBlackColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: selectedDate != null && selectedTime != null
                  ? _submitAppointment
                  : null, // Disable the action if date or time is not selected
              child: CustomButton(
                title: "Submit",
                isHasMultipleWidget: false,
                color: selectedDate != null && selectedTime != null ? bBlackColor : bLowLightGrey,
                textColor: bWhite,
                borderColor: selectedDate != null && selectedTime != null ? bBlackColor : bLowLightGrey,
                radius: 8,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Scheduled Appointments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: bBlackColor,
              ),
            ),
            const SizedBox(height: 10),
            // Removed the ListView.builder that was using the undefined appointmentTimes variable
            Center(
              child: const Text(
                "No scheduled appointments to show.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: bBlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Removed the _appointmentCard method as it was not being used.
}
