import 'package:flutter/material.dart';


class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(0.4),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://emtstatic.com/2009/11/pescador.jpg'),
              radius: 30.0,
            ),
          ),
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.only(right:10.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.amber,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage('https://cdn.pixabay.com/photo/2018/01/05/02/47/fish-3062034_1280.jpg'),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 800),
        ),
      ),
    );
  }
}