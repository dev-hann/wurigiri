import 'package:flutter/material.dart';
import 'package:wurigiri/widget/image_view.dart';

class WImageLayOut extends StatelessWidget {
  const WImageLayOut({
    super.key,
    required this.imageList,
    required this.onTapPhoto,
  });
  final List<ImageProvider> imageList;
  final Function(int index) onTapPhoto;

  Widget image(
    int index, {
    double? width = double.infinity,
    double? height = double.infinity,
  }) {
    return GestureDetector(
      onTap: () {
        onTapPhoto(index);
      },
      child: WImageView(
        imageList[index],
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget one({
    required double width,
  }) {
    return image(
      0,
      width: width,
      height: width,
    );
  }

  Widget two({
    required double width,
  }) {
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return image(
                0,
                width: constraints.maxWidth,
                height: width,
              );
            },
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return image(
                1,
                width: constraints.maxWidth,
                height: width,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget three({
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: width,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: image(
                    0,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: image(
                    1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: image(
              2,
              width: width,
            ),
          ),
        ],
      ),
    );
  }

  Widget four({
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: width,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: image(
                    0,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: image(
                    1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: image(
                    2,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: image(
                    3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget more({
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: width,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: image(
                    0,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: image(
                  1,
                )),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: image(
                    2,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      onTapPhoto(3);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageList[3],
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ColoredBox(
                        color: Colors.black.withOpacity(0.4),
                        child: Center(
                          child: Text(
                            "+${imageList.length - 4}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final list = imageList;
          final length = list.length;
          if (length == 0) {
            return const SizedBox();
          }
          if (length == 1) {
            return one(width: width);
          } else if (length == 2) {
            return two(width: width);
          } else if (length == 3) {
            return three(width: width);
          } else if (length == 4) {
            return four(width: width);
          } else {
            return more(width: width);
          }
        },
      ),
    );
  }
}
