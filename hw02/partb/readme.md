

## Neo4j model

1. Upload dataset csv to somewhere that can be access through HTTP(s). Note that one can upload csv to neo4j desktop as well
2. Run `load_dataset_from_csv.cql` file to load both csv
3. Sanity check to return immidiate friends of the person with `1995` id since 2005

```
MATCH (p:Person)-[know:KNOW]->(friends)
WHERE p.id = 1995 AND know.since >= 2004 
RETURN friends, know;
```

example output:

<img width="1072" alt="Screen Shot 2020-09-26 at 2 39 57 PM" src="https://user-images.githubusercontent.com/35666615/94349004-5de49f80-0006-11eb-8aac-1a63a3eb286c.png">


