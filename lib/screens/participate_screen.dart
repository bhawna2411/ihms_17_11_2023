import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:ihms/screens/participants_detail_non_paid_screen.dart';
import 'package:ihms/screens/participants_detail_screen.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final themeMode = ValueNotifier(2);

class ImageDetail {
  final String path;

  ImageDetail({this.path});
}

getDateFormat(String date) {
  String result2 = Jiffy(DateTime.parse(date)).format('EEE , do MMM yyyy');
  return result2;
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class Participate_Screen extends StatefulWidget {
  @override
  EventData eventData;
  List<String> tags;
  Participate_Screen(this.eventData);
  _MyHomePageState createState() => _MyHomePageState();
}

final _contactEditingController = TextEditingController();

class _MyHomePageState extends State<Participate_Screen> {
  FocusNode myFocusNode = new FocusNode();
  ScrollController controller = ScrollController();
  var _currentDate = DateTime.now();
  var _currentDate1 = DateTime.now();
  List<int> persons = [];
  List<String> participiantName = [];
  List<String> participiantAmount = [];
  var now = DateTime.now();
  var shouldAbsorb;
  var _finalDate;
  _launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    if (widget.eventData.multislot == 1) {
      for (var eachh in widget.eventData.multislotTime) {
        if(now.isBefore(DateTime.parse(eachh.startDate.toString()))){
          for (var pdata in eachh.participants) {
            participiantName.add(pdata.mparticipantName);
            participiantAmount.add(pdata.mamount);
          }
        }
      }
    }
    super.initState();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  getTime(dtime) {
    var ftime = DateFormat('hh:mm a').format(DateTime.parse(dtime));
    return ftime;
  }

  getDate(sdate) {
    String prefix = Jiffy(DateTime.parse(sdate)).format('EEE , do MMM yyyy');
    return prefix;
  }

  String time24to12Format(String time) {
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String send = "";
    if (h > 12) {
      var temp = h - 12;
      send =
          "$temp:${m.toString().length == 1 ? "0" + m.toString() : m.toString()} " +
              "PM";
    } else {
      send =
          "$h:${m.toString().length == 1 ? "0" + m.toString() : m.toString()} " +
              "AM";
    }
    return send;
  }

  @override
  Widget build(BuildContext context) {
    getFinalDate() {
      if (widget.eventData.multislot == 0) {
        _finalDate =
            widget.eventData.start_date + ' ' + widget.eventData.start_time;
        return _finalDate;
      } else {
        if (widget.eventData.multislotTime.length > 0) {

          for (var eachh in widget.eventData.multislotTime) {
            persons.add(DateTime.parse(eachh.startDate.toString())
                .millisecondsSinceEpoch);
          }
          var _fDate =
              persons.reduce((curr, next) => curr > next ? curr : next);
          var dt = DateTime.fromMillisecondsSinceEpoch(_fDate);
          _finalDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
          return _finalDate;
        }
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: widget.eventData.image == null
                  ? Text("data")
                  : CarouselWithIndicatorDemo(widget.eventData.image),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.29,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage("assets/images/bg_color.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: InkWell(
              child: new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  color: Colors.white,
                  onPressed: () => {Navigator.pop(context)}),
            ),
          ),

          Center(
              child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            clipBehavior: Clip.hardEdge,
            children: [
              FittedBox(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20,
                    bottom: MediaQuery.of(context).size.height * 0.10,
                  ),
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(widget.eventData.name,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFba8e1c))),
                            ),
                          ],
                        ),
                      ),

                      widget.eventData.multislot == 0
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Event Time",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFba8e1c))),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_outlined,
                                      size: 15,
                                      color: Color(0xFF90700b),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                        time24to12Format(
                                            widget.eventData.start_time),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xFFcbb269))),
                                    Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xFFcbb269))),
                                    Text(
                                        time24to12Format(
                                            widget.eventData.end_time),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xFFcbb269))),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                          getDateFormat(
                                              widget.eventData.start_date),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                              color: Color(0xFFcbb269))),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Color(0xFFcbb269))),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        getDateFormat(
                                            widget.eventData.end_date),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFFcbb269),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          : Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Event Time",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFba8e1c))),
                                    ],
                                  ),
                                  Container(
                                    width: 300,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: ListView.builder(
                                              padding: EdgeInsets.all(0),
                                              scrollDirection: Axis.vertical,
                                              itemCount: widget.eventData
                                                  .multislotTime.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 15,
                                                      color: Color(0xFF90700b),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "${getTime(widget.eventData.multislotTime[index].startDate)}-${getTime(widget.eventData.multislotTime[index].endDate)}   ${getDate(widget.eventData.multislotTime[index].endDate)}",
                                                      style: TextStyle(
                                                        height: 1.5,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFFcbb269),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("About Event",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFba8e1c))),
                                ],
                              ),
                              Text(widget.eventData.description,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFcbb269))),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Number of Seats Available",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFba8e1c))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("-",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFba8e1c))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      widget
                                          .eventData.number_of_seats_available,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFba8e1c))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                              Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amount",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFba8e1c)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      widget.eventData.multislot == 1
                                          ? Wrap(
                                              spacing: 5,
                                              direction: Axis.vertical,
                                              children: List.generate(
                                                  participiantName.length,
                                                  (index) {
                                                return Text(
                                                  '${participiantName[index].toString()} : \u{20B9} ${participiantAmount[index].toString()}',
                                                  style: TextStyle(
                                                    // fontSize: 10,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFcbb269),
                                                  ),
                                                );
                                              }),
                                            )
                                          : Wrap(
                                              spacing: 5,
                                              direction: Axis.vertical,
                                              children: List.generate(
                                                  widget.eventData.participants
                                                      .length, (index) {
                                                return Text(
                                                  '${widget.eventData.participants[index].participantName.toString()}: \u{20B9} ${widget.eventData.participants[index].amount.toString()}',
                                                  style: TextStyle(
                                                    // fontSize: 10,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFcbb269),
                                                  ),
                                                );
                                              }),
                                            ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                      SizedBox(
                          height:
                              widget.eventData.amount_adult == null ? 5 : 20),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.005,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 0,
                              height: 20,
                              child: Icon(
                                Icons.location_on_sharp,
                                size: 17,
                                color: Color(0xFF90700b),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Text("Location",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFba8e1c))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: widget.eventData.location == null
                            ? Container()
                            : Text(widget.eventData.location,
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFcbb269))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            _launchInBrowser(widget.eventData.url);
                          },
                          child: Row(
                            children: [   
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      const Color(0xFFb48919),
                                      const Color(0xFF9a7210),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          70.0) //                 <--- border radius here
                                      ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "More Info",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          // fontSize: 16,
                                          fontSize: 13,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                          
                            ],
                          )),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
              _currentDate.isAfter(DateTime.parse(getFinalDate())) ||
                      widget.eventData.participate_btn_status.toString() == "0"
                  ? Text("")
                  : Positioned(
                      bottom: 50,
                      child: Container(
                        height: 70,
                        width: 260,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.73,
                        ),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF9a7210), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  70.0) //                 <--- border radius here
                              ),
                          color: Colors.brown,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.eventData.type == "paid") {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ParticipantsDetailScreen(
                                          widget.eventData.id,
                                          widget.eventData.amount_adult,
                                          widget.eventData.amount_child,
                                          widget.eventData.name,
                                          widget.eventData.multislot,
                                          widget.eventData.multislotTime,
                                          widget.eventData),
                                ),
                              );
                            } else {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ParticipantsDetailNonPaid(
                                          widget.eventData.id,
                                          widget.eventData.amount_adult,
                                          widget.eventData.amount_child,
                                          widget.eventData.name,
                                          widget.eventData.multislot,
                                          widget.eventData.multislotTime,
                                          widget.eventData),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 70,
                            width: 260,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color(0xFFb48919),
                                  const Color(0xFF9a7210),
                                ],
                              ),
                              border: Border.all(color: Colors.white, width: 4),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      70.0) //                 <--- border radius here
                                  ),
                            ),
                            child: Center(
                              child: Text("PARTICIPATE NOW!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
        ],
      ),
    ));
  }
}

class DemoItem extends StatelessWidget {
  final String route;
  DemoItem(this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('data'),
      onTap: () {},
    );
  }
}

class BasicDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Scaffold(
      appBar: AppBar(title: Text('Basic demo')),
      body: Container(
          child: CarouselSlider(
        options: CarouselOptions(),
        items: list
            .map((item) => Container(
                  child: Center(child: Text(item.toString())),
                  color: Colors.green,
                ))
            .toList(),
      )),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  String image;
  CarouselWithIndicatorDemo(this.image);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: widget.image == ''
                ? [
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            'https://th.bing.com/th/id/OIP._ZIjfYAE0_HpYth1f-mq2QHaE7?pid=ImgDet&rs=1',
                            fit: BoxFit.cover,
                            height: 2000,
                            width: 2000.0,
                          ),
                        ],
                      ),
                    )
                  ]
                : widget.image
                    .split('##')
                    .map(
                      (img) => Container(
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                img,
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
            carouselController: _controller,
            options: CarouselOptions(
                height: 2000,
                autoPlay: widget.image.split("##").length == 1 ? false : true,
                scrollPhysics: widget.image.split("##").length == 1
                    ? NeverScrollableScrollPhysics()
                    : ScrollPhysics(),
                initialPage: 0,
                viewportFraction: 1.4,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
      ]),
    );
  }
}
