from pydantic import BaseModel


class PredictionRequest(BaseModel):
    sex: float
    age: float
    fare: float
    classe: float
