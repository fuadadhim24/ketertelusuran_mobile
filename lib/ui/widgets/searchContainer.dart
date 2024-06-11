import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketertelusuran_mobile/shared/theme.dart';

class SearchContainer extends StatefulWidget {
  final String hintText;
  const SearchContainer({Key? key, required this.hintText}) : super(key: key);

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: whiteContainerColor,
      ),
      child: Center(
        child: Column(
          children: [
            buildSearchAndFilter(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchAndFilter() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: whiteBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: txtBlackColor,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: IconButton(
                  icon: Icon(Icons.filter_alt, color: whiteContainerColor),
                  onPressed: () {
                    // Tambahkan aksi ketika tombol filter ditekan
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
