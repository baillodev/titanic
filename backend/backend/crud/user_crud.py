# crud/user_crud.py
from backend.models.user_model import User  
from backend.core.security import get_password_hash

def get_user_by_username(db, username: str):
    return db.query(User).filter(User.username == username).first()

def create_user(db, username: str, password: str):
    hashed_password = get_password_hash(str(password))
    db_user = User(username=username, password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

