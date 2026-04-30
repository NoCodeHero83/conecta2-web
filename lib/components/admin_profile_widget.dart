// Thin re-export shim kept for backwards compatibility.
//
// The real implementation now lives under `lib/components/admin_profile/`.
// Existing imports such as `import '/components/admin_profile_widget.dart'`
// continue to resolve without any changes at the call sites.
export 'admin_profile/admin_profile_widget.dart';
