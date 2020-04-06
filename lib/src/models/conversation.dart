import 'package:shareLearnTeach/src/models/chat.dart';
import 'package:shareLearnTeach/src/models/user.dart';
import 'package:flutter/material.dart';

class Conversation {
  String id = UniqueKey().toString();
  List<Chat> chats;
  bool read;
  User user;

  Conversation(this.user, this.chats, this.read);
}

class ConversationsList {
  List<Conversation> _conversations;
  User _currentUser = User.init().getCurrentUser();

  ConversationsList() {
    this._conversations = [
      Conversation(
          User.basic('Kelly R. Hart', 'img/user2.jpg', UserState.available),
          [
            Chat('Supports overlappi', '63min ago',
                User.basic('Kelly R. Hart', 'img/user2.jpg', UserState.available)),
            Chat('Accepts one sliver as content.', '15min ago', _currentUser),
            Chat(
                'Header can ov', '16min ago', User.basic('Kelly R. Hart', 'img/user2.jpg', UserState.available))
          ],
          false),
      Conversation(
          User.basic('Carol R. Hansen', 'img/user0.jpg', UserState.busy),
          [
            Chat('Flutter project, add the following dependency ', '32min ago',
                User.basic('Carol R. Hansen', 'img/user1.jpg', UserState.available)),
            Chat('Can scroll in any direction. ', '42min ago', _currentUser),
            Chat('Notifies when the header scrolls outside the viewport. ', '12min ago',
                User.basic('Carol R. Hansen', 'img/user1.jpg', UserState.available))
          ],
          true),
      Conversation(
          User.basic('Jordan P. Jeffries', 'img/user0.jpg', UserState.away),
          [
            Chat('For help getting started with Flutter ', '31min ago',
                User.basic('Jordan P. Jeffries', 'img/user1.jpg', UserState.available)),
            Chat('Supports overlapping (AppBars for example). ', '31min ago', _currentUser),
            Chat('Accepts one sliver as content. ', '43min ago',
                User.basic('Jordan P. Jeffries', 'img/user1.jpg', UserState.available))
          ],
          false),
      Conversation(
          User.basic('Michele J. Dunn', 'img/user0.jpg', UserState.available),
          [
            Chat('Accepts one sliver as content.', '45min ago',
                User.basic('Michele J. Dunn', 'img/user1.jpg', UserState.available)),
            Chat('Supports overlapping (AppBars for example).', '12min ago', _currentUser),
            Chat('Can scroll in any direction. ', '31min ago',
                User.basic('Michele J. Dunn', 'img/user1.jpg', UserState.available))
          ],
          false),
      Conversation(
          User.basic('Regina R. Risner', 'img/user1.jpg', UserState.away),
          [
            Chat('Can scroll in any direction.  ', '33min ago',
                User.basic('Regina R. Risner', 'img/user1.jpg', UserState.available)),
            Chat('Supports overlapping (AppBars for example). ', '33min ago', _currentUser),
            Chat('Accepts one sliver as content. ', '33min ago',
                User.basic('Regina R. Risner', 'img/user1.jpg', UserState.available))
          ],
          true),
    ];
  }

  List<Conversation> get conversations => _conversations;
}
