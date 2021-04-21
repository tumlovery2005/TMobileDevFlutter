import 'package:intl/intl.dart';

class DateTimeUtils {

  String getDateString(String strDate){
    DateTime date = DateTime.parse(strDate);
    var formetter = DateFormat('dd MMMM yyyy', 'th');
    print('date : ${formetter.format(date)}');
    List<String> parseDate = formetter.format(date).split(" ");
    int year = int.parse(parseDate[2]) + 543;
    String numberDay = parseDate[0];
    if(numberDay[0] == "0"){
      numberDay = strDate[0][1];
    }
    return "${numberDay} ${parseDate[1]} ${year.toString()}";
  }
}