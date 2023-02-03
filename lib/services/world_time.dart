import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{
  String location;
  String time = '';
  String flag;
  String urll;
  bool isDaytime = true;
  WorldTime({ required this.location, required this.flag, required this.urll});
  Future<void> getTime() async {
    var url = Uri.parse('http://worldtimeapi.org/api/timezone/$urll');
    var response = await http.get(url);
    Map data = jsonDecode(response.body); // this requires import dart:convert
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));
    // time = now.toString();
    isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
    time = DateFormat.jm().format(now);
  }
}