import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mapa_elegir_widget.dart' show MapaElegirWidget;
import 'package:flutter/material.dart';

class MapaElegirModel extends FlutterFlowModel<MapaElegirWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Backend Call - API (geocodingSearch)] action in Button widget.
  ApiCallResponse? datosUbicationAPI;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
