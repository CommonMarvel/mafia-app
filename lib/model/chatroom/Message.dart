import 'package:mafia_app/constants/MessageType.dart';
import 'package:mafia_app/model/chatroom/User.dart';

abstract class Message {
  final MessageType type;
  final User from;
  final User to;
  final String contentText;

  Message(this.from, this.to, this.contentText, this.type);
}