from surrealdb import AsyncSurreal

db = AsyncSurreal("ws://localhost:8000")

async def connect():
    await db.connect()
    await db.signin({
        "username": "root",
        "password": "root"
    })
    await db.use("test", "test")