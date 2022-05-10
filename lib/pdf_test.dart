import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:url_launcher/url_launcher.dart';





class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
      style: style,
      text: text ?? url,
      recognizer: new TapGestureRecognizer()
        ..onTap = () {
          launch(url);
        });
}





class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {




  void _viewFile() async {
    final _url =
        'http://www.africau.edu/images/default/sample.pdf';
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      print('Something went wrong');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:   InkWell(
          onTap: _viewFile,
          child: Container(
            color: Colors.blue,
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            child: RichText(
              text:  LinkTextSpan(
                style: TextStyle(
                  color: Colors.black,
                ),
                  //url: 'http://www.africau.edu/images/default/sample.pdf',
                  text: 'Show My Pdf'),
            ),
          ),
        ),
      ),
    );
  }
}
