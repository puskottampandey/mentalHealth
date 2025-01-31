import 'package:flutter/material.dart';
import 'package:mentalhealth/configs/state_model.dart';

class RequestStateWidget<T> extends StatelessWidget {
  final RequestStatus status;
  final Widget Function(T data) onSuccess;
  final T? data;
  final String? errorMessage;
  final TextStyle? errorStyle;

  const RequestStateWidget({
    super.key,
    required this.status,
    required this.onSuccess,
    this.data,
    this.errorMessage = "Something went wrong",
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case RequestStatus.initial:
      case RequestStatus.progress:
      case RequestStatus.fetchingMore:
        return const Center(child: SizedBox.shrink());
      case RequestStatus.success:
        return data != null ? onSuccess(data as T) : const SizedBox.shrink();
      case RequestStatus.failure:
        return Center(
          child: Text(
            errorMessage!,
            style: errorStyle ??
                const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
        );
    }
  }
}
