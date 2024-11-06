import 'package:ecommerce_app/model/item.dart';
import 'package:ecommerce_app/screens/order/component/order_item.dart';
import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String _isActiveStatus = 'Ongoing';
  bool isLoading = true;
  List<Item>? items;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() async {
    List<Item>? data = await fetchOrders();
    setState(() {
      items = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Center(
            child: Text(
              'My Orders',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 24, color: neutral950),
            ),
          ),
          trailing: const Icon(Icons.notifications_none_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
            child: Column(
              children: [
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : items!.isNotEmpty
                        ? Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: primary50,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () => setState(() {
                                            _isActiveStatus = 'Ongoing';
                                          }),
                                          child: Container(
                                            padding: _isActiveStatus ==
                                                    'Ongoing'
                                                ? const EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 10)
                                                : null,
                                            decoration: _isActiveStatus ==
                                                    'Ongoing'
                                                ? BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))
                                                : null,
                                            child: const Text('Ongoing'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => setState(() {
                                            _isActiveStatus = 'Complete';
                                          }),
                                          child: Container(
                                            padding: _isActiveStatus ==
                                                    'Complete'
                                                ? const EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 10)
                                                : null,
                                            decoration: _isActiveStatus ==
                                                    'Complete'
                                                ? BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  )
                                                : null,
                                            child: const Text('Complete'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => setState(() {
                                            _isActiveStatus = 'Review';
                                          }),
                                          child: Container(
                                            padding: _isActiveStatus == 'Review'
                                                ? const EdgeInsets.symmetric(
                                                    vertical: 3, horizontal: 10)
                                                : null,
                                            decoration: _isActiveStatus ==
                                                    'Review'
                                                ? BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))
                                                : null,
                                            child: const Text('Review'),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Column(
                                children: items!
                                    .map((data) => OrderItem(item: data))
                                    .toList(),
                              )
                            ],
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.list_alt,
                                  size: 64,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  'No Ongoing Orders!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontSize: 20, color: neutral950),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                    'You dont have\' any ongoing orders at this time')
                              ],
                            ),
                          )
              ],
            )),
      ),
    );
  }
}
