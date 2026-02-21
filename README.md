# Titanic Survival Prediction

Application full-stack de prediction de survie des passagers du Titanic utilisant des modeles de machine learning.

## Stack technique

- **Backend** : Python / FastAPI
- **Frontend** : Flutter / Dart
- **Machine Learning** : scikit-learn (Logistic Regression, KNN, Decision Tree, Random Forest)

## Structure du projet

```
.
├── backend/                # API FastAPI
│   ├── backend/
│   │   ├── api/            # Endpoints (prediction)
│   │   ├── core/           # Configuration
│   │   ├── models/         # Fichiers .pkl des modeles ML
│   │   ├── schemas/        # Schemas Pydantic (request/response)
│   │   └── services/       # Logique metier (chargement modeles)
│   └── notebooks/          # Notebook Jupyter d'entrainement
├── frontend/               # Application Flutter
│   └── lib/
│       ├── models/         # Modeles de donnees Dart
│       ├── providers/      # State management (Provider)
│       ├── screens/        # Ecrans de l'application
│       ├── services/       # Appels API (Dio)
│       └── utils/          # Constantes et utilitaires
├── docs/                   # Documentation
├── requirements.txt        # Dependances Python
└── .gitignore
```

## Prerequisites

- Python 3.11+
- Flutter SDK 3.10+
- Modeles ML entraines (fichiers `.pkl`)

## Installation

### Backend

```bash
# Creer et activer l'environnement virtuel
python3 -m venv .venv
source .venv/bin/activate

# Installer les dependances
pip install -r requirements.txt

# Configurer les variables d'environnement
cp backend/.env.example backend/.env
```

### Frontend

```bash
cd frontend

# Configurer les variables d'environnement
cp .env.example .env

# Installer les dependances
flutter pub get
```

## Lancement

### Backend

```bash
source .venv/bin/activate
uvicorn backend.backend.main:app --reload
```

L'API est disponible sur `http://127.0.0.1:8000`.
Documentation Swagger : `http://127.0.0.1:8000/docs`.

### Frontend

```bash
cd frontend
flutter run
```

## API

| Methode | Endpoint                        | Description            |
| ------- | ------------------------------- | ---------------------- |
| POST    | `/api/predict?model={nom}`      | Prediction de survie   |

**Modeles disponibles** : `logistic`, `knn`, `decision_tree`, `random_forest`

**Exemple de requete** :

```json
{
  "sex": 1.0,
  "age": 25.0,
  "fare": 50.0,
  "classe": 2.0
}
```

## Entrainement des modeles

Le notebook `backend/notebooks/titanic.ipynb` contient le code d'entrainement des modeles ML. Les modeles generes (`.pkl`) doivent etre places dans `backend/backend/models/`.

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE).
