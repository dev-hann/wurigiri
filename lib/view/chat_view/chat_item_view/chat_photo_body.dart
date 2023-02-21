part of chat_item_view;

class _ChatPhotoBody extends StatelessWidget {
  const _ChatPhotoBody(
    this.chat, {
    required this.width,
    required this.onTapPhoto,
  });
  final double width;
  final PhotoChat chat;
  final Function(int index) onTapPhoto;

  @override
  Widget build(BuildContext context) {
    final url = chat.photoList;
    return SizedBox.square(
      dimension: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          WImageLayOut(
            imageList: chat.thumbList.map((e) => MemoryImage(e)).toList(),
            onTapPhoto: (index) {
              onTapPhoto(index);
            },
          ),
          url.isEmpty ? const WLoading() : const SizedBox(),
        ],
      ),
    );
  }
}
