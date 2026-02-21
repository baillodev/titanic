# Architecture

## Vue d'ensemble

Le projet suit une architecture client-serveur classique :

```
┌─────────────┐       HTTP/REST       ┌─────────────────┐
│   Frontend   │ ──────────────────── │     Backend      │
│   (Flutter)  │   POST /api/predict  │    (FastAPI)     │
└─────────────┘                       └────────┬────────┘
                                               │
                                      ┌────────┴────────┐
                                      │   ML Models      │
                                      │   (scikit-learn) │
                                      └─────────────────┘
```

## Backend

### Structure

```
backend/backend/
├── main.py              # Point d'entree FastAPI, middleware CORS
├── api/
│   └── prediction.py    # Endpoint POST /api/predict
├── core/
│   └── config.py        # Chemins des modeles ML
├── models/
│   ├── *.pkl            # Modeles ML serialises (non versiones)
│   └── .gitkeep
├── schemas/
│   ├── request_schema.py   # PredictionRequest (sex, age, fare, classe)
│   └── response_schema.py  # PredictionResponse (prediction)
└── services/
    └── model_loader.py  # Chargement et cache des modeles, inference
```

### Flux de prediction

1. Le client envoie une requete POST avec les features du passager
2. Le parametre `model` (query string) selectionne le modele ML
3. `model_loader` charge le modele en memoire (lazy loading avec cache)
4. Le modele effectue la prediction (0 = non survie, 1 = survie)
5. Le resultat est retourne au client

### Modeles disponibles

| Modele             | Fichier                         |
| ------------------ | ------------------------------- |
| Logistic Regression| `logistic_model.pkl`            |
| KNN                | `knn_classifier.pkl`            |
| Decision Tree      | `decision_tree_classifier.pkl`  |
| Random Forest      | `random_forest_classifier.pkl`  |

## Frontend

### Structure

```
frontend/lib/
├── main.dart                   # Initialisation app, DI, Provider setup
├── models/
│   ├── titanic.dart            # Modele de donnees passager
│   └── prediction.dart         # Modele de reponse prediction
├── providers/
│   └── prediction_provider.dart # Gestion d'etat des predictions
├── screens/
│   └── home_screen.dart        # Ecran principal (formulaire + resultats)
├── services/
│   └── api_service.dart        # Client HTTP (Dio)
└── utils/
    └── constants.dart          # URL API, configuration
```

### Flux utilisateur

1. L'utilisateur remplit le formulaire (sex, age, fare, classe)
2. Il selectionne un modele ML dans le dropdown
3. Le `PredictionProvider` envoie la requete via `ApiService`
4. Le resultat est affiche : verdict (survie/non survie) + probabilite

### State Management

Le projet utilise **Provider** (`ChangeNotifier`) pour la gestion d'etat reactive.

## Configuration

### Variables d'environnement

**Backend** (`backend/.env`) : aucune variable requise actuellement.

**Frontend** (`frontend/.env`) :
- `API_BASE_URL` : URL de base de l'API backend (defaut: `http://127.0.0.1:8000`)
