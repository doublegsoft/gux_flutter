import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

class Images {

  static Future<Uint8List?> captureWidget(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = (await image.toByteData(format: ui.ImageByteFormat.png)) as ByteData?;
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Uint8List?> fetchImageBytes(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Failed to fetch image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching image: $e');
      return null;
    }
  }

  static Future<Uint8List> createThumbnail(Uint8List originalImageBytes, int targetWidth, int targetHeight) async {
    final img.Image? originalImage = img.decodeImage(originalImageBytes);
    if (originalImage == null) {
      return Future.error("Failed to decode image");
    }
    final img.Image thumbnail = img.copyResize(
      originalImage,
      width: targetWidth,
      height: targetHeight,
    );
    return Uint8List.fromList(img.encodePng(thumbnail));
  }

  static Future<void> resizeImageFile({
    required File file,
    double scale = 1.0,
    int threshold = 400,
  }) async {
    if (!await file.exists()) {
      return ;
    }
    Uint8List bytes =  await file.readAsBytes();
    Size size = await getImageSizeFromBytes(bytes);
    if (size.width <= threshold) {
      return;
    }
    bytes = await createThumbnail(bytes, (size.width * scale).toInt(), (size.height * scale).toInt());
    await file.writeAsBytes(bytes, flush: true);
  }

  static Future<Size> getImageSizeFromBytes(Uint8List imageBytes) async {
    final Completer<Size> completer = Completer<Size>();
    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      completer.complete(Size(img.width.toDouble(), img.height.toDouble()));
    });
    return completer.future;
  }

}