from pydantic import BaseModel

class UserCreate(BaseModel):
    username: str
    password: str

# Requête pour la prédiction
class RegressionLogisticRequest(BaseModel):
    sex:    float
    age:    float
    fare:   float
    classe: float
