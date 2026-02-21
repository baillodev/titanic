from fastapi import APIRouter, Query
from backend.schemas.request_schema import RegressionLogisticRequest
from backend.schemas.response_schema import RegressionLogisticResponse
from backend.services.model_loader import predict

router = APIRouter()

@router.post("/predict", response_model=RegressionLogisticResponse)
def make_prediction(
    data: RegressionLogisticRequest,
    model_name: str = Query("logistic", enum=["logistic","knn","decision_tree","random_forest"])
):
    features = [
        data.sex,
        data.age,
        data.fare,
        data.classe,
    ]

    prediction = predict(features, model_name=model_name)
    return RegressionLogisticResponse(prediction=prediction)
