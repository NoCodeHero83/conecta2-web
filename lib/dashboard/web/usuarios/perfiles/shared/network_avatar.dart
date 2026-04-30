import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Network image that degrades gracefully to an asset placeholder when the
/// remote URL fails (e.g. Firebase Storage 412 / 403 / expired tokens).
class NetworkAvatar extends StatelessWidget {
  const NetworkAvatar({
    super.key,
    required this.url,
    this.size = 40.0,
    this.fallbackAsset = 'assets/images/User.png',
    this.fit = BoxFit.cover,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.backgroundColor,
  });

  final String? url;
  final double size;
  final String fallbackAsset;
  final BoxFit fit;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final trimmed = (url ?? '').trim();
    final hasUrl = trimmed.isNotEmpty && Uri.tryParse(trimmed)?.hasScheme == true;

    Widget fallback = Image.asset(
      fallbackAsset,
      width: size,
      height: size,
      fit: fit,
    );

    final child = hasUrl
        ? CachedNetworkImage(
            imageUrl: trimmed,
            width: size,
            height: size,
            fit: fit,
            fadeInDuration: const Duration(milliseconds: 300),
            fadeOutDuration: const Duration(milliseconds: 300),
            errorWidget: (_, __, ___) => fallback,
            placeholder: (_, __) => Container(
              width: size,
              height: size,
              color: backgroundColor ?? const Color(0xFFD9D9D9),
            ),
          )
        : fallback;

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFD9D9D9),
        shape: shape,
        borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
      ),
      child: child,
    );
  }
}
