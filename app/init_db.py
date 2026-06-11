import asyncio
from db import connect, db

async def run():
    print("🚀 INIT DATABASE")

    await connect()

    notebook = await db.create("notebook", {
        "title": "CD104CE Notebook",
        "description": "Init system",
        "user_id": "user_1"
    })

    source = await db.create("source", {
        "title": "Sample Source",
        "content": "Hello SurrealDB",
        "source_type": "text",
        "status": "unprocessed",
        "notebook_id": notebook["id"]
    })

    print("✔ Notebook:", notebook)
    print("✔ Source:", source)

asyncio.run(run())