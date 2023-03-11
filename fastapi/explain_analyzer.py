# id, select_type, table, paritions, type, possible_keys, key, key_len, ref, rows, filtered, Extras
from enum import Enum,auto

class SelectType(Enum):
    SIMPLE=auto()
    PRIMARY=auto()
    UNION=auto()
    DEPENDENT_UNION=auto()
    UNION_RESULT=auto()
    SUBQUERY=auto()
    DEPENDENT_SUBQUERY=auto()
    DERIVED=auto()
    DEPENDENT_DERIVED=auto()
    UNCACHEABLE_SUBQUERY=auto()
    UNCACHEABLE_UNION=auto()
    MATERIALIZED=auto()

class Type(Enum):
    SYSTEM=auto()
    CONST=auto()
    EQ_REF=auto()
    REF=auto()
    FULLTEXT=auto()
    REF_OR_NULL=auto()
    UNIQUE_SUBQUERY=auto()
    INDEX_SUBQUERY=auto()
    RANGE=auto()
    INDEX_MERGE=auto()
    INDEX=auto()
    ALL=auto()

class Extra(Enum):
    CONST_ROW_NOT_FOUND=auto()
    DELETING_ALL_ROWS=auto()
    DISTINCT=auto()
    FIRSTMATCH=auto()
    FULL_SCAN_ON_NULL_KEY=auto()
    IMPOSSIBLE_HAVING=auto()
    IMPOSSIBLE_WHERE=auto()
    LOOSESCAN=auto()
    NO_MATCHING_MIN_MAX_ROW=auto()
    NO_MATCHING_ROW_IN_CONST_TABLE=auto()
    NO_MATCHING_ROWS_ALTER_PARTITION_PRUNING=auto()
    NO_TABLES_USED=auto()
    NOT_EXISTS=auto()
    PLAN_ISNT_READY_YET=auto()
    RANGE_CHECKED_FOR_EACH_RECORD=auto()
    RECURSIVE=auto()
    REMATERIALIZE=auto()
    SELECT_TABLES_OPTIMIZED_AWAY=auto()
    START_TEMPORARY=auto()
    END_TEMPORARY=auto()
    UNIQUE_ROW_NOT_FOUND=auto()
    USING_FILESORT=auto()
    USING_INDEX=auto()
    USING_INDEX_CONDITION=auto()
    USING_INDEX_FOR_GROUP_BY=auto()
    USING_INDEX_FOR_SKIP_SCAN=auto()
    USING_JOIN_BUFFER=auto()
    USING_MRR=auto()
    USING_SORT_UNION=auto()
    USING_UNION=auto()
    USING_INTERSECT=auto()
    USING_TEMPORARY=auto()
    USING_WHERE=auto()
    ZERO_LIMIT=auto()


# Explain record 저장하는 클래스
# 하나의 record가 쿼리실행단위가 되어 실행 순서 및 효율성을 검증
class QueryUnit:
    def __init__(self,
                 q_id,
                 q_select_type,
                 q_table,
                 q_partitions,
                 q_type,
                 q_possible_keys,
                 q_key,
                 q_key_len,
                 q_ref,
                 q_rows,
                 q_filtered,
                 q_extras) -> None:
        self.id=q_id
        self.select_type=q_select_type
        self.table=q_table
        self.partition=q_partitions
        self.type=q_type
        self.possible_keys=q_possible_keys
        self.key=q_key
        self.key_len=q_key_len
        self.ref=q_ref
        self.rows=q_rows
        self.filtered=q_filtered
        self.extras=q_extras
    

def analyze(explains: list()) -> None:
    # 같은 id 끼리 묶기
    # 