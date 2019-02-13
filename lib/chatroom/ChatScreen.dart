import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mafia_app/constants/Color.dart';
import 'package:mafia_app/model/chatroom/Message.dart';
import 'package:mafia_app/model/chatroom/TextMessage.dart';
import 'package:mafia_app/model/chatroom/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatScreen extends StatefulWidget {
  final String peerId;

  ChatScreen({Key key, @required this.peerId}) : super(key: key);

  @override
  State createState() => ChatScreenState(peerId: peerId);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId});

  String peerId;
  String id;
  SharedPreferences prefs;
  bool isLoading;
  List<Message> _mockData;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    isLoading = false;
    id = '0000';
    _mockData = [
      TextMessage(aUser, me, "Hello"),
      TextMessage(bUser, me, "Hello"),
      TextMessage(aUser, me, "ASDASD"),
      TextMessage(me, me, "Self"),
      TextMessage(bUser, me, "asdmkiv"),
      TextMessage(aUser, me, "sdv,mdlsfmosdfowefikjdsjfklsnvskdfksdlfjlskvnksdjfklsdjf"),
      TextMessage(me, me, "Self"),
      TextMessage(bUser, me, "asdmkiv"),
      TextMessage(aUser, me, "sdv,mdlsfmosdfowefikjdsjfklsnvskdfksdlfjlskvnksdjfklsdjf"),
      TextMessage(me, me, "Self"),
      TextMessage(me, me, "Self"),
      TextMessage(aUser, me, "sdv,mdlsfmosdfowefikjdsjfklsnvskdfksdlfjlskvnksdjfklsdjfmdlsfmosdfowefikjdsjfklsnvskdfksdlfjlskvnksdjfklsdjfmdlsfmosdfowefikjdsjfklsnvskdfksdlfjlskvnksdjfklsdjfmdlsfmosdfowefikjdsjfklsnvskdfksdlfjlskvnksdjfklsdjf"),
    ];
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // when keyboard appear
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim() != '') {
      setState(() {
        _mockData.insert(0, TextMessage(me, me, content));
      });
      textEditingController.clear();
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget buildItem(int index, TextMessage message) {
    if (fromMe(message)) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              message.contentText,
              style: TextStyle(color: primaryColor),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Material(
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            message.from.userId,
                            style: TextStyle(color: primaryColor)
                          ),
                          margin: EdgeInsets.only(left: 10.0),
                        ),
                    ),
                    Container(
                      child: Text(
                        message.contentText,
                        style: TextStyle(color: Colors.white),
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      width: 200.0,
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
                      margin: EdgeInsets.only(left: 10.0),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool fromMe(Message message) {
    return message.from.userId == id;
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildListMessage(),
              buildInput(),
            ],
          ),
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
        ),
        color: Colors.white.withOpacity(0.8),
      )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
        child: ListView.builder(padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => buildItem(index, _mockData[index]),
          itemCount: _mockData.length,
          reverse: true,
          controller: listScrollController,
    )
    );
  }
}

final aUser = User("a001");
final bUser = User("b001");
final me = User("0000");