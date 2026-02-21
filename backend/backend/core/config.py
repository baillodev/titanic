import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

class Settings:
    MODELS = {
        "logistic": os.path.join(BASE_DIR, "..", "models", "logistic_model.pkl"),
        "knn": os.path.join(BASE_DIR, "..", "models", "knn_classifier.pkl"),
        "decision_tree": os.path.join(BASE_DIR, "..", "models", "decision_tree_classifier.pkl"),
        "random_forest": os.path.join(BASE_DIR, "..", "models", "random_forest_classifier.pkl"),
    }

settings = Settings()
