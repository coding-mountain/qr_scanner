// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ImageView extends StatefulWidget {
  Uint8List? image;

 ImageView({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
      if (widget.image != null) {
        return   Image(image: MemoryImage(widget.image!));

          //   showDialog(
          //     context: context,
          //     builder: (context) =>
          //         Image(image: MemoryImage(image)),
          //   );
          //   Future.delayed(const Duration(seconds: 5), () {
          //     Navigator.pop(context);
          //   });
          // }
  }else{
    return Placeholder();
  }
}
}