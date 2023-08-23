import 'package:flutter/material.dart';
import 'package:ihms/models/AmenitiesResponseModel.dart';
import 'package:ihms/screens/amenities_book_slot.dart';
import 'package:table_calendar/table_calendar.dart';

class AmenitiesBookingType extends StatefulWidget {
  Datumm amenitiesListData;
  AmenitiesBookingType(this.amenitiesListData);

  @override
  State<AmenitiesBookingType> createState() => _AmenitiesBookingTypeState();
}

class _AmenitiesBookingTypeState extends State<AmenitiesBookingType> {
  String dropdownValue;
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    dropdownValue = widget.amenitiesListData.bookingType;
    setState(() {});
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text(widget.amenitiesListData.name,
              style: TextStyle(
                  color: Color(0xFF90700b), fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("<${widget.amenitiesListData.amenityPayType}>",
                style: TextStyle(
                    color: Color(0xFF90700b),
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            SizedBox(
              height: 30,
            ),
            Text("BOOKING TYPE",
                style: TextStyle(
                    color: Color(0xFFcbb269),
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFcbb269), width: 2.0),
                  bottom: BorderSide(color: Color(0xFFcbb269), width: 2.0),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon:
                      Icon(Icons.keyboard_arrow_down, color: Color(0xFFcbb269)),
                  isExpanded: true,
                  value: dropdownValue,
                  items: <String>[
                    'Single',
                    'Multiple',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(color: Color(0xFFcbb269))),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    dropdownValue = newValue;
                    setState(() {});
                    print(dropdownValue);
                  },
                  hint: Text('Select an option'),
                ),
              ),
            ),
            SizedBox(height: 10),
            TableCalendar(
              calendarController: _calendarController,
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFcbb269)),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Color(0xFFcbb269)),
                weekdayStyle: TextStyle(color: Color(0xFFcbb269)),
              ),
              calendarStyle: CalendarStyle(
                outsideStyle: TextStyle(color: Color(0xFFcbb269)),
                weekdayStyle: TextStyle(color: Color(0xFFcbb269)),
                holidayStyle: TextStyle(color: Color(0xFFcbb269)),
                weekendStyle: TextStyle(color: Color(0xFFcbb269)),
                outsideHolidayStyle: TextStyle(color: Color(0xFFcbb269)),
                outsideWeekendStyle: TextStyle(color: Color(0xFFcbb269)),
                eventDayStyle: TextStyle(color: Color(0xFFcbb269)),
              ),
              headerVisible: true,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AmenitiesBookSlot(widget.amenitiesListData))); 
              },
              child: Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFcbb269),
                    ),
                    child: Text(
                      "Book Slot",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    )),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
