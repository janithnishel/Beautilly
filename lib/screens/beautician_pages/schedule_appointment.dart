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

  // Appointments list for the current customer
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments(); // Fetch appointments when the widget initializes
  }

  Future<void> _fetchAppointments() async {
    try {
      int? customerId = GlobalUser.customerId;
      if (customerId == null) {
        throw Exception("Customer ID is null");
      }

      // Fetch the list of appointments for the current customer
      List<Map<String, dynamic>> fetchedAppointments = await ApiService.getAppointmentsByCustomer(customerId);

      setState(() {
        appointments = fetchedAppointments;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      Fluttertoast.showToast(
        msg: "Failed to fetch appointments.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

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

      // Refresh the list of appointments
      await _fetchAppointments();

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

  Future<void> _deleteAppointment(int appointmentId) async {
    try {
      await ApiService.deleteAppointment(appointmentId);

      Fluttertoast.showToast(
        msg: "Appointment deleted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Refresh the list of appointments
      await _fetchAppointments();
    } catch (e) {
      print('Error deleting appointment: $e');
      Fluttertoast.showToast(
        msg: "Failed to delete appointment.",
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
            Expanded(
              child: appointments.isEmpty
                  ? const Center(
                      child: Text(
                        "No scheduled appointments to show.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: bBlackColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return _appointmentCard(appointments[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appointmentCard(Map<String, dynamic> appointment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomBox(
        blurRadius: 1,
        shadowOfset: const Offset(0, 2),
        shadowColor: bhightLightGrey,
        height: 80, // Adjusted height
        borderRadius: 5,
        color: bWhite,
        width: MediaQuery.of(context).size.width,
        widget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.date_range_sharp,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Appointment #${appointment['Appointment_ID']}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: bBlackColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Date: ${appointment['Date']}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: bBlackColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Time: ${appointment['Time']}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: bBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteAppointment(appointment['Appointment_ID']);
                },
              ),
            ],
          ),
        ),
        isHaSBorder: false,
      ),
    );
  }
}
