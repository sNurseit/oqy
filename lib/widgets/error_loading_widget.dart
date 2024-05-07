import 'package:flutter/material.dart';

class ErrorLoadingWidget extends StatelessWidget {
  final VoidCallback onTryAgain;
  const ErrorLoadingWidget({super.key,required this.onTryAgain, });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          const Text(
            'Something went wrong'
          ),
          OutlinedButton(
            onPressed: onTryAgain, 
            child: const Text("Try again")
          )
        ]
      ),
    );
  }

}

