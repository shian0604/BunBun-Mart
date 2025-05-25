import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class CloudHelperFunctions {
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? error,
    Widget? nothingFound,
    Widget? loader,
  }) {
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(
        child: BTextBold(text: "Nothing found", color: BunColors.black),
      );
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(
        child: BTextBold(text: "Something went wrong", color: BunColors.black),
      );
    }

    return null;
  }
}
