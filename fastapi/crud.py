from sqlalchemy import text
from database import get_connection

def getExplain( q: str):
    db = get_connection()
    return db.execute(text('EXPLAIN '+q)).all()