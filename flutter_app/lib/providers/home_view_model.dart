import 'package:flutter/material.dart';
import 'package:flutter_app/models/message_bubble.dart';
import 'package:flutter_app/services/message_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeViewModel extends ChangeNotifier {
  static final String _localIpAddress = '10.0.0.102';
  final String _localUrl = 'http://$_localIpAddress:4200';

  bool _isChatting = true;
  final List<MessageBubble> _messages = [];
  final TextEditingController messageController = TextEditingController();

  bool get isChatting => _isChatting;
  List<MessageBubble> get messages => _messages;
  late final WebViewController _webViewController;
  WebViewController get webViewController => _webViewController;

  final List<String> _replyMessages = [
    "Hi there! We are happy to assist you.",
    "We are looking into your query.",
    "Thanks for reaching out to us.",
  ];
  final ScrollController scrollController = ScrollController();
  final MessageStorageService _storageService = MessageStorageService();
  bool _isPersistenceEnabled = false;

  HomeViewModel() {
    _initializeWebView();
    _initializeChatData();
  }

  Future<void> _initializeChatData() async {
    await _storageService.init();
    _isPersistenceEnabled = _storageService.getPersistenceEnabled();
    if (_isPersistenceEnabled) {
      _messages.addAll(await _storageService.loadMessages());
    }

    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  set isPersistenceEnabled(bool value) {
    _isPersistenceEnabled = value;
    _storageService.setPersistenceEnabled(value);
    notifyListeners();
  }

  void _initializeWebView() {
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                debugPrint('Web View is loading (progress: $progress%)');
              },
              onPageFinished: (String url) {
                debugPrint('Page finished loading: $url');
              },
              onWebResourceError: (WebResourceError error) {
                debugPrint('Web View Error: ${error.description} ');
              },
            ),
          )
          ..loadRequest(Uri.parse(_localUrl));
  }

  void toggleView() {
    _isChatting = !_isChatting;
    notifyListeners();
  }

  void sendMessage() {
    final userMessageText = messageController.text.trim();

    if (userMessageText.isNotEmpty) {
      _messages.add(
        MessageBubble(
          message: userMessageText,
          time: DateTime.now(),
          isUser: true,
        ),
      );

      _messages.sort();
      if (_isPersistenceEnabled) _storageService.saveMessages(_messages);

      messageController.clear();
      notifyListeners();

      Future.delayed(const Duration(milliseconds: 700), () {
        final replyText =
            _replyMessages[_messages.length % _replyMessages.length];
        _messages.add(
          MessageBubble(
            message: replyText,
            time: DateTime.now(),
            isUser: false,
          ),
        );

        _messages.sort((a, b) => a.compareTo(b));
        if (_isPersistenceEnabled) _storageService.saveMessages(_messages);
        notifyListeners();
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
