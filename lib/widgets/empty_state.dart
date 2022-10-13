import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/image/empty_state.svg',
                              width: 120,
                            ),
                            const SizedBox(height: 15),
                            const Text('Your taks list is empty...')
                          ]),
                    );
  }
}