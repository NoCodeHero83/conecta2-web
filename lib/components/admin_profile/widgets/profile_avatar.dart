import '/auth/firebase_auth/auth_util.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Left column of the profile screen: photo + name + role.
///
/// Handles avatar rendering (including the decorative shadow container) and
/// the "pick a new photo" InkWell. Upload state is owned by the parent via
/// [uploadedFileUrl] / [onFileUploaded] callbacks — this avoids duplicating
/// state and keeps the FlutterFlow model the single source of truth.
class ProfileAvatarPanel extends StatelessWidget {
  const ProfileAvatarPanel({
    super.key,
    required this.uploadedFileUrl,
    required this.onUploadStart,
    required this.onUploadEnd,
    required this.onFileUploaded,
  });

  final String uploadedFileUrl;
  final VoidCallback onUploadStart;
  final VoidCallback onUploadEnd;
  final void Function(FFUploadedFile file, String downloadUrl) onFileUploaded;

  static const _fallbackPhoto =
      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/conecta2-wtnr9n/assets/9yllj3p8hz5o/User.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 50.0,
            color: Color(0x26000000),
            offset: Offset(20.0, 20.0),
          )
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatarStack(context),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 0.0, 10.0),
                    child: AuthUserStreamWidget(
                      builder: (context) => Text(
                        currentUserDisplayName,
                        style: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              font: GoogleFonts.inter(),
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                  AuthUserStreamWidget(
                    builder: (context) => Text(
                      valueOrDefault(currentUserDocument?.rol, ''),
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            font: GoogleFonts.inter(),
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarStack(BuildContext context) {
    final imageUrl = uploadedFileUrl.isNotEmpty
        ? uploadedFileUrl
        : valueOrDefault<String>(currentUserPhoto, _fallbackPhoto);

    return Stack(
      alignment: const AlignmentDirectional(1.0, 1.0),
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
          child: AuthUserStreamWidget(
            builder: (context) => Container(
              width: 106.0,
              height: 106.0,
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              // Use a child Image.network with an errorBuilder — DecorationImage
              // has no error handling, which is the bug we want to fix here.
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 106.0,
                height: 106.0,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFD9D9D9),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.person,
                    size: 60.0,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => _handlePhotoPick(context),
          child: Container(
            width: 35.0,
            height: 35.0,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(
              'assets/images/Group_273.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFF6BD33),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handlePhotoPick(BuildContext context) async {
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      allowPhoto: true,
    );
    if (selectedMedia == null ||
        !selectedMedia
            .every((m) => validateFileFormat(m.storagePath, context))) {
      return;
    }

    onUploadStart();
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
        selectedMedia.map<Future<String?>>(
          (m) async => await uploadData(m.storagePath, m.bytes),
        ),
      ))
          .where((u) => u != null)
          .map((u) => u!)
          .toList();
    } finally {
      onUploadEnd();
    }

    if (selectedUploadedFiles.length == selectedMedia.length &&
        downloadUrls.length == selectedMedia.length) {
      onFileUploaded(selectedUploadedFiles.first, downloadUrls.first);
    }
  }
}
