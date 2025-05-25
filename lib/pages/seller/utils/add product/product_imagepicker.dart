import 'dart:typed_data';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ProductImagePickerAdaptive extends StatefulWidget {
  final Function(List<Uint8List>) onImagesSelected;

  const ProductImagePickerAdaptive({super.key, required this.onImagesSelected});

  @override
  State<ProductImagePickerAdaptive> createState() =>
      _ProductImagePickerAdaptiveState();
}

class _ProductImagePickerAdaptiveState
    extends State<ProductImagePickerAdaptive> {
  final List<Uint8List> _imageBytesList = [];

  Future<void> _pickImages() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final images =
            result.files
                .where((file) => file.bytes != null)
                .map((file) => file.bytes!)
                .toList();
        setState(() {
          _imageBytesList.addAll(images);
        });
        widget.onImagesSelected(_imageBytesList);
      }
    } else {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage(imageQuality: 75);

      if (pickedFiles.isNotEmpty) {
        final images = await Future.wait(
          pickedFiles.map((file) => file.readAsBytes()),
        );
        setState(() {
          _imageBytesList.addAll(images);
        });
        widget.onImagesSelected(_imageBytesList);
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageBytesList.removeAt(index);
    });
    widget.onImagesSelected(_imageBytesList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: BunColors.navy,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/upload_image.png",
                    height: 28,
                    width: 28,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Tap to upload images",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: BunColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_imageBytesList.isNotEmpty)
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _imageBytesList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        _imageBytesList[index],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: CircularIcons(
                        imagepath: "assets/icons/minus_w.png",
                        imageheight: 8,
                        imagewidth: 8,
                        height: 24,
                        width: 24,
                        padding: EdgeInsets.all(0),
                        color: BunColors.navy,
                        onPressed: () => _removeImage(index),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
