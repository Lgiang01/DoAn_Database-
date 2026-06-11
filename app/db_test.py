import asyncio
from db import db, connect

async def main():
    await connect()

    notebooks = await db.select("notebook")
    sources = await db.select("source")

    print("NOTEBOOK")
    print(notebooks)

    print()

    print("SOURCE")
    print(sources)

asyncio.run(main())