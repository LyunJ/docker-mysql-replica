from sqlalchemy import create_engine
SQLALCHEMY_DATABASE_URL = "mysql://webuser:password@localhost/employees"
# SQLALCHEMY_DATABASE_URL = "postgresql://user:password@postgresserver/db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL
)
_conn = None
def get_connection():
    global _conn 
    if not _conn:
        _conn = engine.connect()
    return _conn