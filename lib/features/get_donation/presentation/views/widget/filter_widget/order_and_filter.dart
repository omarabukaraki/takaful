import 'package:flutter/material.dart';
import '../../filter_page.dart';
import 'filter_result_button.dart';

class OrderAndFilter extends StatelessWidget {
  const OrderAndFilter({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(children: [
          // Expanded(child:
          //        OrderButton(onTap: () {
          //         print('order');
          //       })
          //       ),
          Expanded(
              flex: 2,
              child: FilterResultButton(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    context: context,
                    builder: (context) {
                      return const FilterPage();
                    },
                  );
                },
              )),
        ]),
      ),
    );
  }
}
