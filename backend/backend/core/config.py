from pathlib import Path

MODELS_DIR = Path(__file__).resolve().parent.parent / "models"

MODELS = {
    "logistic": MODELS_DIR / "logistic_model.pkl",
    "knn": MODELS_DIR / "knn_classifier.pkl",
    "decision_tree": MODELS_DIR / "decision_tree_classifier.pkl",
    "random_forest": MODELS_DIR / "random_forest_classifier.pkl",
}
