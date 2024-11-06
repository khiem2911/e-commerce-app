import 'package:ecommerce_app/screens/search/component/custom_search.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Search> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        child: Column(
          children: [
            CustomSearch(
              onTap: () {},
              autoFocus: _searchFocusNode,
              readOnly: true,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Text(
                  'Popular Searches',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, color: neutral950),
                ),
                const Spacer(),
                Text(
                  'Clear All',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: neutral900),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
