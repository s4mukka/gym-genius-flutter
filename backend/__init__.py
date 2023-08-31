from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.security import OAuth2PasswordBearer
from typing import List, Dict
from pydantic import BaseModel  # Adicione esta linha

app = FastAPI()

# Simulated database
users_db = {}
workouts_db = {}

# OAuth2 PasswordBearer for token-based authentication
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


# Models
class UserCreate(BaseModel):
    username: str
    password: str

class User(UserCreate):
    id: int


class Exercise(BaseModel):
    id: int
    name: str
    image: str

class WorkoutCreate(BaseModel):
    workoutName: str
    exercises: List[Exercise]


class Workout(BaseModel):
    workoutName: str
    exercises: List[Exercise]


# Helper functions
def get_current_user(token: str = Depends(oauth2_scheme)):
    # Simulated user authentication
    user = users_db.get(token)
    if not user:
        raise HTTPException(status_code=401, detail="Unauthorized")
    return user


# Endpoints
@app.post("/user/create", response_model=User)
async def create_user(user_create: UserCreate):
    user = User(
      id=len(users_db) + 1,
      **user_create.dict()
    )
    users_db[user.username] = user
    return user


@app.post("/user/login")
async def login_for_access_token(user_create: UserCreate):
    # Simulated user authentication
    user = users_db.get(user_create.username)
    if user and user.password == user_create.password:
        return {"access_token": user.username, "token_type": "bearer"}
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Incorrect username or password",
        headers={"WWW-Authenticate": "Bearer"},
    )


@app.post("/workout/create")
async def create_workout(workout_create: WorkoutCreate, current_user: User = Depends(get_current_user)):
    workouts_db[workout_create.workoutName] = workout_create
    return workout_create


@app.get("/workout", response_model=List[Workout])
async def get_workouts(current_user: User = Depends(get_current_user)):
    user_workouts = []
    print(workouts_db)
    for workout_name, workout_data in workouts_db.items():
        user_workouts.append(Workout(workoutName=workout_name, exercises=workout_data.exercises))
    print(user_workouts)
    return user_workouts


@app.get("/workout/{workoutName}", response_model=Workout)
async def get_workout(workoutName: str, current_user: User = Depends(get_current_user)):
    workout_data = workouts_db.get(workoutName)
    if not workout_data:
        raise HTTPException(status_code=404, detail="Workout not found")
    return Workout(workoutName=workoutName, exercises=workout_data.exercises)


@app.delete("/workout/{workoutName}/delete")
async def delete_workout(workoutName: str, current_user: User = Depends(get_current_user)):
    if workoutName in workouts_db:
        del workouts_db[workoutName]
        return {"message": "Workout deleted"}
    raise HTTPException(status_code=404, detail="Workout not found")


@app.put("/workout/{workoutName}/edit")
async def edit_workout(workoutName: str, edited_workout: WorkoutCreate, current_user: User = Depends(get_current_user)):
    if workoutName in workouts_db:
        workouts_db[workoutName] = edited_workout
        return {"message": "Workout edited"}
    raise HTTPException(status_code=404, detail="Workout not found")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
