part of 'mapa_instituciones_educativas.dart';

class SearchableBarrioDialog extends StatefulWidget {
  final List<String> barrios;
  final String? barrioSeleccionado;
  final Function(String?) onBarrioSelected;

  const SearchableBarrioDialog({
    Key? key,
    required this.barrios,
    required this.barrioSeleccionado,
    required this.onBarrioSelected,
  }) : super(key: key);

  @override
  _SearchableBarrioDialogState createState() => _SearchableBarrioDialogState();
}

class _SearchableBarrioDialogState extends State<SearchableBarrioDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _barriosFiltrados = [];

  // Getter para el color primario con valor por defecto
  Color get primaryColor {
    final theme = FlutterFlowTheme.of(context);
    return theme.primary ?? Colors.blue;
  }

  @override
  void initState() {
    super.initState();
    _barriosFiltrados = widget.barrios;
  }

  void _filtrarBarrios(String query) {
    setState(() {
      if (query.isEmpty) {
        _barriosFiltrados = widget.barrios;
      } else {
        _barriosFiltrados = widget.barrios
            .where(
                (barrio) => barrio.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 400,
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.map,
                    color: primaryColor,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Seleccionar Barrio',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Barra de búsqueda
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: _filtrarBarrios,
                decoration: InputDecoration(
                  hintText: 'Buscar barrio...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _filtrarBarrios('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            // Opción "Todos"
            ListTile(
              leading: Icon(
                Icons.select_all,
                color: widget.barrioSeleccionado == null
                    ? primaryColor
                    : Colors.grey,
              ),
              title: Text(
                'Todos',
                style: TextStyle(
                  fontWeight: widget.barrioSeleccionado == null
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: widget.barrioSeleccionado == null
                      ? primaryColor
                      : Colors.black87,
                ),
              ),
              selected: widget.barrioSeleccionado == null,
              onTap: () {
                widget.onBarrioSelected(null);
                Navigator.of(context).pop();
              },
            ),
            Divider(height: 1),
            // Lista de barrios
            Expanded(
              child: _barriosFiltrados.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No se encontraron barrios',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _barriosFiltrados.length,
                      itemBuilder: (context, index) {
                        final barrio = _barriosFiltrados[index];
                        final isSelected = barrio == widget.barrioSeleccionado;

                        return ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: isSelected ? primaryColor : Colors.grey,
                          ),
                          title: Text(
                            barrio,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? primaryColor : Colors.black87,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color: primaryColor,
                                )
                              : null,
                          selected: isSelected,
                          onTap: () {
                            widget.onBarrioSelected(barrio);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
