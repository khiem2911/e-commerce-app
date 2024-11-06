import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/country.dart';
import 'package:ecommerce_app/route/route_constant.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchLocationState();
  }
}

class _SearchLocationState extends State<SearchLocation> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  List<Country>? _countries;
  List<Country>? _filterCountries;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    List<Country> results = await fetchCountries();
    setState(() {
      _countries = results;
    });
  }

  void _updateLocation(String country, String capital) async {
    String location = '$country, $capital';

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'location': location}).then((_) {
      Navigator.pushNamedAndRemoveUntil(
          context, tabsBottomRoute, (Route<dynamic> route) => false);
    });
  }

  void _onSearchLocation(String value) {
    final countriesResult = _countries!
        .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {
      _filterCountries = countriesResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Your Location',
          style:
              Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Card(
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      _searchController.text = value;
                      _onSearchLocation(value);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Find your location',
                        suffixIcon: _searchController.text != ''
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _searchController.text = '';
                                  });
                                },
                                icon: const Icon(Icons.close))
                            : null,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(width: 1, color: primary500))),
                  ),
                )),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isLoading = true;
                });
                getCurrentLocation(() {
                  setState(() {
                    isLoading = false;
                  });
                }, context);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.send,
                        color: primary700,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Use my current location',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: neutral950),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            _filterCountries != null && _searchController.text != ''
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Search Result'),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _filterCountries!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => _updateLocation(
                                      _filterCountries![index].name,
                                      _filterCountries![index].capital.join()),
                                  leading: const Icon(
                                    Icons.send,
                                    color: primary700,
                                  ),
                                  title: Text(
                                      '${_filterCountries![index].name}, ${_filterCountries![index].capital.join('')}'),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                : const Center(child: Text('try to search a country')),
          ],
        ),
      ),
    );
  }
}
