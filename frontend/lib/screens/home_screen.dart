import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titanic_app/models/titanic.dart';
import 'package:titanic_app/providers/prediction_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _sexController = TextEditingController();
  final _ageController = TextEditingController();
  final _fareController = TextEditingController();
  final _classeController = TextEditingController();

  String? _usedModel;
  String _selectedModel = "logistic";

  final List<Map<String, String>> _models = [
    {"label": "Logistic Regression", "value": "logistic"},
    {"label": "KNN", "value": "knn"},
    {"label": "Decision Tree", "value": "decision_tree"},
    {"label": "Random Forest", "value": "random_forest"},
  ];

  @override
  void dispose() {
    _sexController.dispose();
    _ageController.dispose();
    _classeController.dispose();
    _fareController.dispose();
    super.dispose();
  }

  void _predict() {
    if (_formKey.currentState!.validate()) {
      final data = Titanic(
        sex: double.parse(_sexController.text),
        age: double.parse(_ageController.text),
        fare: double.parse(_fareController.text),
        classe: double.parse(_classeController.text),
      );

      setState(() {
        _usedModel = _selectedModel;
      });

      Provider.of<PredictionProvider>(
        context,
        listen: false,
      ).makePrediction(data, modelName: _selectedModel);

      _formKey.currentState!.reset();
      _sexController.clear();
      _ageController.clear();
      _fareController.clear();
      _classeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final predictionState = context.watch<PredictionProvider>();
    final predictionResult = predictionState.prediction;
    final errorMessage = predictionState.errorMessage;

    final bool didSurvive =
        predictionResult != null && predictionResult.prediction >= 0.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Titanic Prediction"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  children: [
                    TextFormField(
                      controller: _sexController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une valeur.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.male),
                        labelText: "Sex",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une valeur.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_today),
                        labelText: "Age",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _fareController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une valeur.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Fare",
                        prefixIcon: const Icon(Icons.directions_walk),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _classeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une valeur.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.folder),
                        labelText: "Classe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    DropdownButtonFormField<String>(
                      value: _selectedModel,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.memory),
                        labelText: "Modele ML",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: _models.map((model) {
                        return DropdownMenuItem<String>(
                          value: model["value"],
                          child: Text(model["label"]!),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedModel = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez choisir un modele";
                        }
                        return null;
                      },
                    ),

                    Selector<PredictionProvider, bool>(
                      selector: (context, provider) => provider.isLoading,
                      builder: (context, isLoading, child) {
                        return SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _predict,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Predire",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Erreur: $errorMessage",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    if (predictionResult != null)
                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Modele utilise",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Chip(
                                    label: Text(
                                      _usedModel == null
                                          ? "--"
                                          : _models.firstWhere(
                                              (m) => m["value"] == _usedModel,
                                            )["label"]!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: didSurvive
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      didSurvive
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: didSurvive
                                          ? Colors.blue
                                          : Colors.red,
                                      size: 26,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        didSurvive
                                            ? "Survie probable"
                                            : "Survie improbable",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: didSurvive
                                              ? Colors.blue
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              Text(
                                "Probabilite estimee",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 6),

                              LinearProgressIndicator(
                                value: predictionResult.prediction.clamp(
                                  0.0,
                                  1.0,
                                ),
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(8),
                                backgroundColor: Colors.grey.shade300,
                                color: didSurvive ? Colors.blue : Colors.red,
                              ),

                              const SizedBox(height: 8),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${(predictionResult.prediction * 100).toStringAsFixed(1)} %",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
