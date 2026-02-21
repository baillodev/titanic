from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from backend.core.database import get_db
from backend.core.security import verify_password, create_access_token
from backend.crud.user_crud import get_user_by_username, create_user
from backend.schemas.request_schema import UserCreate
from backend.schemas.response_schema import Token



router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/register", response_model=Token)
def register(user: UserCreate, db: Session = Depends(get_db)):
    if get_user_by_username(db, user.username):
        raise HTTPException(status_code=400, detail="Username already exists")
    new_user = create_user(db, user.username, user.password)
    token = create_access_token({"sub": new_user.username})
    return {"access_token": token, "username": new_user.username}

@router.post("/login", response_model=Token)
def login(user: UserCreate, db: Session = Depends(get_db)):
    db_user = get_user_by_username(db, user.username)
    if not db_user or not verify_password(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    token = create_access_token({"sub": db_user.username})
    return {"access_token": token, "username":db_user.username}
