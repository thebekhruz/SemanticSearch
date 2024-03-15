
// Explore shortcut pattern
MATCH shortcutPattern = (rsr:Resource)<-[co:HAS_PARENT*2..]-(child)-[shortcut:HAS_PARENT]->(rsr)
return shortcutPattern limit 10




// Delete shortcut pattern
MATCH shortcutPattern = (rsr:Resource)<-[co:HAS_PARENT*2..]-(child)-[shortcut:HAS_PARENT]->(rsr) 
DELETE shortcut






// ##### Merge Named Entities with wikidata through wiki_ID ####§
// Merge Named Entities with wikidata through url
// Match all Resource nodes where the uri is not null
MATCH (r:Resource) WHERE r.uri IS NOT NULL

// Use WITH to pass r and also prepare the identifier part of the uri for comparison
WITH r, LAST(SPLIT(r.uri, "/")) AS rIdentifier

// For each entity type, match based on the identifier extracted from the wiki_ID
// Match all Resource nodes where the uri is not null
MATCH (r:Resource) WHERE r.uri IS NOT NULL

// Use WITH to pass r and also prepare the identifier part of the uri for comparison
WITH r, LAST(SPLIT(r.uri, "/")) AS rIdentifier

// For each entity type, match based on the identifier extracted from the wiki_ID

// PERSON
OPTIONAL MATCH (p:PERSON)
WHERE p.wiki_ID CONTAINS rIdentifier
MERGE (p)-[:refers_to]->(r)

// Repeat the WITH statement to carry r and rIdentifier to the next MATCH operation
WITH r, rIdentifier

// ORGANISATION
MATCH (o:ORGANISATION)
WHERE o.wiki_ID CONTAINS rIdentifier
MERGE (o)-[:refers_to]->(r)


MATCH (l:LOCATION)
WHERE l.wiki_ID CONTAINS rIdentifier
MERGE (l)-[:refers_to]->(r)


MATCH (m:MISCELLANEOUS)
WHERE m.wiki_ID CONTAINS rIdentifier
MERGE (m)-[:refers_to]->(r)




// CREATING INDEXES //

CALL db.index.vector.createNodeIndex('document-embeddings', 'Document', 'text_embedding', 768, 'cosine')


text: High Wycombe Police Station and Town Hall Queen Victoria Road, High Wycombe. late 1935 Police Station and Town Hall viewed side on and commemorative bridge over River Wye on western side
text: Library staff pose for a publicity photograph after reorganisation of Reference Library, Queen Victoria Rd, High Wycombe. after 1994. After reorganisation of Reference Library photograph by Bucks Free Press, staff standing in for members of the public