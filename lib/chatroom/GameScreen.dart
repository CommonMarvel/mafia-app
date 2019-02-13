import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mafia_app/chatroom/ChatScreen.dart';
import 'package:mafia_app/constants/Color.dart';

class GameScreen extends StatelessWidget {
  GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GameView',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/gameScreen_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ChatScreen(peerId: 'connect_room_id'),
      ),
    );
  }
}