import 'package:flutter/material.dart';
import 'package:wurigiri/widget/image_view.dart';

class WPhotoView extends StatefulWidget {
  const WPhotoView({
    super.key,
    required this.photoList,
    this.initIndex = 0,
  });

  final List<String> photoList;
  final int initIndex;

  @override
  State<WPhotoView> createState() => _WPhotoViewState();
}

class _WPhotoViewState extends State<WPhotoView> {
  late final List<ImageProvider> providerList;
  final PageController pageController = PageController(keepPage: true);

  final ValueNotifier<bool> _tapNotifier = ValueNotifier(false);

  Widget tapBuilder({
    required Widget child,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: _tapNotifier,
      builder: (context, isTap, _) {
        return AnimatedOpacity(
          opacity: isTap ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: IgnorePointer(
            ignoring: !isTap,
            child: child,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final list = widget.photoList;
    providerList = List.generate(
      list.length,
      (index) => NetworkImage(list[index]),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      pageController.jumpToPage(widget.initIndex);
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    for (final provider in providerList) {
      await precacheImage(provider, context);
    }
  }

  Widget appBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        tapBuilder(
          child: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.4),
            title: Text("!!@@"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.photoList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _tapNotifier.value = !_tapNotifier.value;
                },
                child: _PageImage(
                  url: widget.photoList[index],
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: appBar(),
          ),
        ],
      ),
    );
  }
}

class _PageImage extends StatefulWidget {
  const _PageImage({
    required this.url,
  });
  final String url;

  @override
  State<_PageImage> createState() => _PageImageState();
}

class _PageImageState extends State<_PageImage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InteractiveViewer(
      child: WImageView(
        widget.url,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
