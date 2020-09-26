// part a) For all  Nebraskan, find their immediate friends.
MATCH (p:Person)-[know:KNOW]->(friends)
	WHERE p.state = 'Nebraska'
    RETURN friends;


// part b) For all Nebraskan, find their immediate friends since 2005
MATCH (p:Person)-[know:KNOW]->(friends)
	WHERE p.state = 'Nebraska' AND know.since >= 2005
    RETURN friends;

// part c) For all Nebraskan, find the persons who have the maximum number of immidiate friends
MATCH (p:Person)-[know:KNOW]->(friends)
    WHERE p.state = 'Nebraska'
    RETURN p.id, p.name, COUNT(know) as connections
    ORDER BY connections DESC
    LIMIT 1;

// part d) Find the persons with the maximum number of immidiate friends
MATCH (p:Person)-[know:KNOW]->(friends)
    RETURN p.id, p.name, COUNT(know) as connections
    ORDER BY connections DESC
    LIMIT 1;
