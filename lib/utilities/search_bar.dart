import 'package:bunbunmart/data/controller/user/user_searchcontroller.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final void Function(String)? onSubmitted;
  const MySearchBar({super.key, this.onSubmitted});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final UserSearchController searchController = UserSearchController.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: searchController.searchController,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12, // Increased size for better readability
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: "Search...",
          hintStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF828282),
          ),
    
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 12.0),
            child: Image.asset(
              "assets/icons/search.png",
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
          ),
    
           prefixIconConstraints: BoxConstraints(
            maxHeight: 50,
            maxWidth: 50,
           )
        ),

        onSubmitted: widget.onSubmitted
      ),
    );
  }
}
