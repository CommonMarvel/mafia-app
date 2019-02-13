import 'package:mafia_app/constants/MessageType.dart';
import 'package:mafia_app/model/chatroom/Message.dart';

class TextMessage extends Message {
  TextMessage(from, to, contentText): super(from, to, contentText, MessageType.text);
}