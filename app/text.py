import subprocess

print("RUN INIT DB")
subprocess.run(["python", "app/init_db.py"])

print("RUN DB TEST")
subprocess.run(["python", "app/db_test.py"])

print("DONE")