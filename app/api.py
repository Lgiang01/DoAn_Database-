from fastapi import FastAPI
from db import db, connect

app = FastAPI()

@app.on_event("startup")
async def startup():
    await connect()

@app.get("/notebooks")
async def get_notebooks():
    return await db.select("notebook")

@app.get("/sources")
async def get_sources():
    return await db.select("source")