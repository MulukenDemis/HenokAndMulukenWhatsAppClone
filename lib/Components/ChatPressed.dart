import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:mulukenapp/DataCenter/ChatData.dart';

import 'Chats.dart';

class ChatPressed extends StatefulWidget {
  const ChatPressed({super.key});

  @override
  State<ChatPressed> createState() => _ChatPressedState();
}

late Size size;
bool onchangedvalue = false;
String name = '';
String message = '';

final _controller = TextEditingController();

class _ChatPressedState extends State<ChatPressed> {
  List<Message> messages = [
    Message(
      text: 'hi',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'hi bro how u?',
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'am good how was the day bro',
      date: DateTime.now().subtract(
        const Duration(days: 3, minutes: 1),
      ),
      isSentByMe: false,
    ),
    Message(
      text: 'its fine how about u',
      date: DateTime.now().subtract(Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'its good thanks',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'do u have time tpmorrow',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'yes sure',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'i have question to u',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'ok see u tommorrow',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'ok buy',
      date: DateTime.now().subtract(Duration(days: 5, minutes: 1)),
      isSentByMe: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff075e54),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: const Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 0, top: 2, bottom: 2),
                height: size.height * 0.08,
                width: size.width * 0.4,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(MyChatdata[currentIndex].image),
                  ),
                  title: Text(
                    MyChatdata[currentIndex].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 1, top: 2, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.video_call,
                        size: 33,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    const Icon(
                      Icons.call,
                      size: 36,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    PopupMenuButton(itemBuilder: ((context) {
                      return const [
                        PopupMenuItem(
                          child: Text('View contact'),
                        ),
                        PopupMenuItem(
                          child: Text('Media , link and docs'),
                        ),
                        PopupMenuItem(
                          child: Text('search'),
                        ),
                        PopupMenuItem(
                          child: Text('mute notification'),
                        ),
                        PopupMenuItem(
                          child: Text('Disappearing messages'),
                        ),
                        PopupMenuItem(
                          child: Text('Walpaper'),
                        ),
                        PopupMenuItem(
                          child: Text('more'),
                        ),
                      ];
                    }))
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: GroupedListView<Message, DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    elements: messages,
                    groupBy: (message) => DateTime(
                          message.date.year,
                          message.date.month,
                          message.date.day,
                        ),
                    groupHeaderBuilder: (Message message) => SizedBox(
                          height: 40,
                          child: Center(
                            child: Card(
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  DateFormat.yMMMd().format(message.date),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    itemBuilder: (context, Message message) => Align(
                          alignment: message.isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(message.text),
                            ),
                          ),
                        ))),
            Row(
              children: [
                Container(
                  width: size.width - 60,
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.face_outlined,
                          color: Color.fromARGB(255, 26, 108, 28),
                        ),
                        suffixIcon: Icon(
                          Icons.camera_alt_outlined,
                          color: Color.fromARGB(255, 26, 108, 28),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 8.0),
                        hintText: 'type your message here...'),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                name.isEmpty
                    ? const Icon(
                        Icons.mic,
                        size: 33,
                        color: Color.fromARGB(255, 40, 159, 102),
                      )
                    : IconButton(
                        onPressed: () {
                          final message = Message(
                            text: _controller.text,
                            date: DateTime.now(),
                            isSentByMe: true,
                          );
                          setState(() {
                            messages.add(message);
                          });
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 35,
                          color: Color.fromARGB(255, 40, 159, 102),
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  Message({required this.text, required this.date, required this.isSentByMe});
}
