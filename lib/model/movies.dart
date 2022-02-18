import "package:http/http.dart" as http;
import 'dart:convert';

class Movies {
  late String mname;
  // late String posterURL;
  late String rating = 'a';

  Movies(String name) {
    mname = name;
    mname.replaceAll(' ', '+');
  }
  Movies.withname(String name, String rating) {
    mname = name;
    rating = rating;
  }
  Future<void> getRating() async {
    var url = 'http://www.omdbapi.com/?t=${mname}&apikey=5dc2abe2';
    http.Response response = await http.get(Uri.parse(url));
    Map data = json.decode(response.body);
    rating = data["imdbRating"];
  }
}
