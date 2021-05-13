import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

const thumbNailUrl = 'https://image.tmdb.org/t/p/w500/';
const originalImgUrl = 'https://image.tmdb.org/t/p/original/';

abstract class MyImageBuilder {
  static Widget buildThumbNail(String url, {bool original = false}) {
    return original
        ? Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: const AssetImage('assets/film_icon.png'),
                image: NetworkImage(thumbNailUrl + url),
                fit: BoxFit.cover,
              ),
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(originalImgUrl + url),
                imageErrorBuilder: (context, error, stackTrace) {
                  return SizedBox();
                },
                fit: BoxFit.cover,
              ),
            ],
          )
        : Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: const Color(0x23FFFFFF),
                child: Center(
                  child: const Icon(
                    CupertinoIcons.film,
                    size: 50,
                    color: const Color(0x8AFFFFFF),
                  ),
                ),
              ),
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(thumbNailUrl + url),
                imageErrorBuilder: (context, error, stackTrace) {
                  return SizedBox();
                },
                fit: BoxFit.cover,
              ),
            ],
          );
  }
}

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);

class TransparentImage {
  static Uint8List get tranparentImage => kTransparentImage;
}
