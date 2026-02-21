import joblib
from backend.core.config import settings

_loaded_models = {}

def get_model(model_name: str):
    if model_name not in settings.MODELS:
        raise ValueError(f"Model '{model_name}' not found")

    if model_name not in _loaded_models:
        _loaded_models[model_name] = joblib.load(settings.MODELS[model_name])

    return _loaded_models[model_name]

def predict(features: list, model_name: str = "logistic"):
    model = get_model(model_name)
    result = model.predict([features])
    return int(result[0])  # classification 0/1
