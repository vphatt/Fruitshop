// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'search.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => //{
          showSearch(
              context: context,
              delegate:
                  Search()), // Navigator.of(context).push(MaterialPageRoute(builder: (_) => Search())); //
      // },
      child: Container(
        width: double.infinity,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Tìm kiếm',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }
}
