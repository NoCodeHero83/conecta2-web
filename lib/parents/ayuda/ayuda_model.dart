import '/components/footer_parents/footer_parents_widget.dart';
import '/components/profesional_header/profesional_header_widget.dart';
import '/components/registartion_button/registartion_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ayuda_widget.dart' show AyudaWidget;
import 'package:flutter/material.dart';

class AyudaModel extends FlutterFlowModel<AyudaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel1;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel2;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel3;
  // Model for registartionButton component.
  late RegistartionButtonModel registartionButtonModel4;
  // Model for ProfesionalHeader component.
  late ProfesionalHeaderModel profesionalHeaderModel;
  // Model for footerParents component.
  late FooterParentsModel footerParentsModel;

  @override
  void initState(BuildContext context) {
    registartionButtonModel1 =
        createModel(context, () => RegistartionButtonModel());
    registartionButtonModel2 =
        createModel(context, () => RegistartionButtonModel());
    registartionButtonModel3 =
        createModel(context, () => RegistartionButtonModel());
    registartionButtonModel4 =
        createModel(context, () => RegistartionButtonModel());
    profesionalHeaderModel =
        createModel(context, () => ProfesionalHeaderModel());
    footerParentsModel = createModel(context, () => FooterParentsModel());
  }

  @override
  void dispose() {
    registartionButtonModel1.dispose();
    registartionButtonModel2.dispose();
    registartionButtonModel3.dispose();
    registartionButtonModel4.dispose();
    profesionalHeaderModel.dispose();
    footerParentsModel.dispose();
  }
}
