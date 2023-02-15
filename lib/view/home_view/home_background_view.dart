part of home_view;

class _HomeBackgroundView extends StatelessWidget {
  const _HomeBackgroundView({
    required this.url,
    required this.child,
  });
  final String url;
  final Widget child;

  Widget emptyView() {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.transparent,
            Colors.black.withOpacity(0.1),
          ],
        ).createShader(bounds);
      },
      child: ColoredBox(
        color: WColor.pink,
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget imageView(String url) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.transparent,
            Colors.black.withOpacity(0.6),
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
    return Stack(
      fit: StackFit.expand,
      children: [
        url.isEmpty ? emptyView() : imageView(url),
        child,
      ],
    );
  }
}
