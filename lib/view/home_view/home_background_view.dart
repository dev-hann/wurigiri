part of home_view;

class _HomeBackgroundView extends StatelessWidget {
  const _HomeBackgroundView({
    super.key,
    required this.child,
  });
  final Widget child;

  Widget emptyView() {
    return const ColoredBox(
      color: Colors.white,
      child: SizedBox.expand(),
    );
  }

  Widget imageView(String url) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.transparent,
            Colors.white,
          ],
        ).createShader(bounds);
      },
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (controller) {
        final url = controller.public.mainPhoto;
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onLongPress: () {},
              child: url.isEmpty ? emptyView() : imageView(url),
            ),
            child,
          ],
        );
      },
    );
  }
}
