import '/auth/firebase_auth/auth_util.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Default user avatar URL, used when the current user has no photoUrl set.
const String kDefaultProfileAvatar =
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/conecta2-wtnr9n/assets/9yllj3p8hz5o/User.png';

/// The profile header: circular avatar plus an inline button to pick and
/// upload a new photo.
///
/// The parent state owns the upload state - this widget just triggers the
/// picker and reports results back through [onUploaded].
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.uploadedFileUrl,
    required this.onUploading,
    required this.onUploaded,
  });

  final String uploadedFileUrl;
  final ValueChanged<bool> onUploading;

  /// Called with (file, downloadUrl) when an upload succeeds.
  final void Function(FFUploadedFile file, String downloadUrl) onUploaded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          alignment: const AlignmentDirectional(1.0, 1.0),
          children: [
            AuthUserStreamWidget(
              builder: (context) => Container(
                width: 120.0,
                height: 120.0,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                  imageUrl: valueOrDefault<String>(
                    uploadedFileUrl.isNotEmpty
                        ? uploadedFileUrl
                        : valueOrDefault<String>(
                            currentUserPhoto,
                            kDefaultProfileAvatar,
                          ),
                    kDefaultProfileAvatar,
                  ),
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Image.network(
                    kDefaultProfileAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.person, size: 60),
                  ),
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _pickAndUpload(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/Group_274.png',
                  width: 35.0,
                  height: 35.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickAndUpload(BuildContext context) async {
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      allowPhoto: true,
    );
    if (selectedMedia == null) return;
    if (!selectedMedia
        .every((m) => validateFileFormat(m.storagePath, context))) {
      return;
    }
    onUploading(true);
    var selectedUploadedFiles = <FFUploadedFile>[];
    var downloadUrls = <String>[];
    try {
      selectedUploadedFiles = selectedMedia
          .map((m) => FFUploadedFile(
                name: m.storagePath.split('/').last,
                bytes: m.bytes,
                height: m.dimensions?.height,
                width: m.dimensions?.width,
                blurHash: m.blurHash,
                originalFilename: m.originalFilename,
              ))
          .toList();

      downloadUrls = (await Future.wait(
        selectedMedia.map((m) async => await uploadData(m.storagePath, m.bytes)),
      ))
          .where((u) => u != null)
          .map((u) => u!)
          .toList();
    } finally {
      onUploading(false);
    }
    if (selectedUploadedFiles.length == selectedMedia.length &&
        downloadUrls.length == selectedMedia.length) {
      onUploaded(selectedUploadedFiles.first, downloadUrls.first);
    }
  }
}
