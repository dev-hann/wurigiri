part of chat_item_view;

class _PhotoChatBody extends StatelessWidget {
  const _PhotoChatBody(
    this.chat, {
    required this.width,
  });
  final double width;
  final PhotoChat chat;

  @override
  Widget build(BuildContext context) {
    final url = chat.photoURL;
    if (url.isEmpty) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.memory(
            chat.thumbData,
            fit: BoxFit.cover,
            width: width,
            height: width,
          ),
          const WLoading(),
        ],
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: width,
      height: width,
    );
  }
}
