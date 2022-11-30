import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var i = 0;

  @override
  void initState() {
    _loadNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //Photo Of Numbers
              _sizedBox(70, 0),
              Center(
                child: InkWell(
                  onTap: () {
                    i += 1;
                    setState(() {});
                  },
                  child: Image.asset(
                    "assets/number.jpg",
                    width: 275,
                    height: 250,
                  ),
                ),
              ),

              //Number Counter View
              _sizedBox(15, 0),
              _text("$i"),

              //Button For Save Or Clear
              _sizedBox(64, 0),
              _buttons("Save", isSave: true),

              _sizedBox(27, 0),
              _buttons("Clear", isSave: false),
            ],
          ),
        ),
      ),
    );
  }

  //Method For Text Views
  Widget _text(String number) {
    return Text(number,
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 54));
  }

  //Method For Buttons
  Widget _buttons(String title, {isSave = true}) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(175, 48),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white),
        onPressed: () {
          isSave == true ? _saveNumber() : _clear();
          setState(() {});
        },
        child: Text(title,
            style: const TextStyle(fontSize: 17, color: Colors.white)));
  }

  //Method Of Save Number
  _saveNumber() async {
    var sp = await SharedPreferences.getInstance();
    sp.setInt("numberCount", i);
    Fluttertoast.showToast(msg: "Save Complete");
    setState(() {});
  }

  void _loadNumber() async {
    var sp = await SharedPreferences.getInstance();
    setState(() {});
    i = sp.getInt("numberCount") ?? i;
  }

  _clear() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("numberCount");
    i = 0;
    Fluttertoast.showToast(msg: "Clear Complete");
    setState(() {});
  }

  //Sized Box
  Widget _sizedBox(double height, double width) {
    return SizedBox(height: height, width: width);
  }
}
