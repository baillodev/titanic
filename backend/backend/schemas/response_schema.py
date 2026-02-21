from pydantic import BaseModel

# Réponse pour le JWT
class Token(BaseModel):
    access_token: str
    username: str

# Réponse pour la prédiction
class RegressionLogisticResponse(BaseModel):
    prediction: float
