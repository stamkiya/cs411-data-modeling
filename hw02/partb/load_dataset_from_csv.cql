// remove all nodes and relationships
MATCH (n)
    DETACH DELETE n;


// LOAD persons.csv (note that the URL path is different based on environment)
LOAD CSV WITH HEADERS FROM "http://localhost:11001/project-5c23e13a-df4f-4cc3-929f-52bace6b96ef/persons.csv" AS line 
    MERGE (a:Person { 
        id: toInteger(line.id),  
        name: line.name,
        state: line.name
    });

// LOAD friends.csv (note that the URL path is different based on environment)

LOAD CSV WITH HEADERS FROM "http://localhost:11001/project-5c23e13a-df4f-4cc3-929f-52bace6b96ef/friends.csv" AS line 
    MATCH (p:Person { id: toInteger(line.personId) })
    MATCH (f:Person { id: toInteger(line.friendId) })
    CREATE (p)-[:KNOW { since: toInteger(line.year) }]->(f)

