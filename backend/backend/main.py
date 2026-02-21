from fastapi import FastAPI
from backend.api.prediction import router as PredictRouter
from backend.core.database import Base, engine
from fastapi.middleware.cors import CORSMiddleware
from backend.api import auth

app = FastAPI(
    title="Api-Prediction des survivants du bateau titanic",
    version= "1.0.1",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

Base.metadata.create_all(bind=engine)

app.include_router(PredictRouter, prefix="/api")
app.include_router(auth.router)

