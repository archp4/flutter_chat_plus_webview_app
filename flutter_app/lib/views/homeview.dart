import 'package:flutter/material.dart';
import 'package:flutter_app/models/message_bubble.dart';
import 'package:flutter_app/providers/home_view_model.dart';
import 'package:flutter_app/widgets/message_bubble_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.isChatting ? "Chat Room" : "Dashboard"),
        actions: [
          IconButton(
            icon: Icon(viewModel.isChatting ? Icons.dashboard : Icons.chat),
            onPressed: () {
              viewModel.toggleView();
            },
          ),
        ],
      ),
      body:
          viewModel.isChatting
              ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    color: Colors.grey[200],
                    child: _buildChats(viewModel),
                  ),
                  Positioned(
                    child: _buildInput(viewModel),
                    bottom: 0,
                    left: 0,
                    right: 0,
                  ),
                ],
              )
              : WebViewWidget(controller: viewModel.webViewController),
    );
  }

  _buildInput(HomeViewModel viewModel) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: viewModel.messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),

                onSubmitted: (_) => viewModel.sendMessage(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                viewModel.sendMessage();
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildChats(HomeViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.messages.length,
        itemBuilder: (context, index) {
          return MessageBubbleWidget(
            messageBubble: MessageBubble(
              message: viewModel.messages[index].message,
              time: viewModel.messages[index].time,
              isUser: viewModel.messages[index].isUser,
            ),
          );
        },
      ),
    );
  }
}
