import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/repo/repo.dart';
import 'package:wurigiri/widget/loading.dart';

abstract class Controller<T extends Repo> extends GetxController {
  Controller(this.repo);
  final T repo;
  bool _inited = false;

  bool get isInited => _inited;
  @mustCallSuper
  Future init() async {
    if (_inited) {
      return;
    }
    await repo.init();
    _inited = true;
  }

  static Future<T> put<T extends Controller>(T controller) async {
    final c = Get.put<T>(controller);
    await controller.init();
    return c;
  }

  static overlayLoading({
    required Future Function() asyncFunction,
  }) {
    return Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const WLoading(),
    );
  }

  @Deprecated("will be deprecated")
  Future loadingOverlay({
    required Future Function() asyncFunction,
  }) {
    return Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const WLoading(),
    );
  }
}
