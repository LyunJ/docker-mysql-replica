from fastapi import FastAPI

from sqlalchemy import Connection
from crud import getExplain
from pydantic import BaseModel

class DBInfo(BaseModel):
    url: str
    username: str
    password: str


app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/api/explain")
def read_item(q: str):
    # id, select_type, table, paritions, type, possible_keys, key, key_len, ref, rows, filtered, Extras
    # [(1, 'SIMPLE', 'salaries', None, 'ALL', None, None, None, None, 2838426, 100.0, None)]
    explains: list() = getExplain(q)
    print(explains)
    
    return {  }