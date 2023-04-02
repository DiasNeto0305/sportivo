import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/models/place.dart';

class PlacesForm extends StatefulWidget {
  const PlacesForm({Key? key}) : super(key: key);

  @override
  _PlacesFormState createState() => _PlacesFormState();
}

class _PlacesFormState extends State<PlacesForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  String _flagListType = 'string';
  File? _storedImage;
  bool _isAddPage = true;
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final place = arg as Place;
        _formData['id'] = place.id;
        _formData['name'] = place.name;
        _formData['description'] = place.description;
        _formData['address'] = place.address;
        _formData['categoryId'] = place.categoryId;
        _formData['urlImage'] = place.urlImage;
        _isAddPage = false;
      }
    }
  }

  void _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images!.length > 0) {
      _formData['urlImage'] = [];
      for (var image in images) {
        setState(() {
          _storedImage = File(image.path);
        });
        final appDir = await getApplicationDocumentsDirectory();
        String fileName = path.basename(_storedImage!.path);
        final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
        (_formData['urlImage'] as List).add(savedImage);
      }
      _flagListType = 'File';
    }
  }

  void _submitForm() {
    setState(() {
      _loading = true;
    });
    _formKey.currentState?.save();
    Provider.of<PlaceController>(context, listen: false)
        .savePlace(_formData, _flagListType)
        .then((value) {
      setState(() {
        _loading = false;
      });
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlaceController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isAddPage ? 'Adicionar Local' : 'Editar Local'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    initialValue: (_formData['name'] ?? '') as String,
                    decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    textInputAction: TextInputAction.next,
                    onSaved: (name) => _formData['name'] = name ?? '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    initialValue: (_formData['description'] ?? '') as String,
                    decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onSaved: (description) =>
                        _formData['description'] = description ?? '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    initialValue: (_formData['address'] ?? '') as String,
                    decoration: InputDecoration(
                      labelText: 'Endereço',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (address) => _formData['address'] = address ?? '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownButtonFormField<dynamic>(
                    value: _formData['categoryId'],
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: provider.categories.map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(
                        value: value['id'],
                        child: Text(value['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _formData['categoryId'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: FaIcon(FontAwesomeIcons.images),
                      label: Text(_isAddPage
                          ? 'Selecionar Imagens'
                          : 'Alterar Imagens'),
                      onPressed: _pickImages,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: _loading
                          ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            )
                          : FaIcon(FontAwesomeIcons.paperPlane),
                      label: Text('Salvar'),
                      onPressed: _loading ? null : _submitForm,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
