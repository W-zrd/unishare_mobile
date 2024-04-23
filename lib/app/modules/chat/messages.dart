import 'package:flutter/material.dart';
import 'package:unishare/app/modules/chat/chatroom.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chat',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ChatWidget(
            muted: message.muted,
            contactName: message.contactName,
            lastMessage: message.lastMessage,
            time: message.time,
            unreadCount: message.unreadCount,
          );
        },
      ),
    );
  }
}

class ChatMessage {
  final String contactName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool muted;

  ChatMessage({
    required this.muted,
    required this.contactName,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });
}

final List<ChatMessage> messages = [
  ChatMessage(
    muted: false,
    contactName: "Gaahh?!",
    lastMessage: "Omagaaahh",
    time: "9:30 AM",
    unreadCount: 2,
  ),
  ChatMessage(
    muted: false,
    contactName: "Amerika Yaaa",
    lastMessage: "Haro haro haro",
    time: "Yesterday",
    unreadCount: 0,
  ),
  ChatMessage(
    muted: true,
    contactName: "Akashi Seijuroo",
    lastMessage: "Boku no mere o zettai da",
    time: "Sunday",
    unreadCount: 5,
  ),
];

class ChatWidget extends StatelessWidget {
  final String contactName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool muted;

  const ChatWidget({
    Key? key,
    required this.muted,
    required this.contactName,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(contactName[0]),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // New addition
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contactName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  if (contactName == "Amerika Yaaa")
                    Icon(
                      Icons.check_circle,
                      size: 17,
                    )
                  else
                    Icon(
                      Icons.check_circle_outline,
                      size: 17,
                    ),
                  Text(lastMessage),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 12), // Adjust time font size
              ),
              Row(
                children: [
                  if (muted)
                    Icon(
                      Icons.volume_off,
                      size: 17,
                    ),
                  if (unreadCount > 0)
                    CircleAvatar(
                      backgroundColor: Colors.orange.shade700,
                      radius: 10,
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12), // Adjust unread count font size
                      ),
                    )
                  else
                    SizedBox(
                      height: 25,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          ),
        );
      },
    );
  }
}
