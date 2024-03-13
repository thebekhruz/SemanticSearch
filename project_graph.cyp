CALL gds.graph.project(
  'documentGraph', 
  {
    DOCUMENT: {properties: ['text_embedding']}
  },
  {
    MENTIONS: {type: 'MENTIONS', properties: ['total_tfidf_score']},
    MENTIONED_ON: {type: 'MENTIONED_ON', properties: ['total_tfidf_score']}
  }
)
YIELD graphName, nodeCount, relationshipCount






CALL gds.graph.project(
  'documentGraph', // This is the name assigned to the in-memory graph being created. It's how you'll refer to this graph in subsequent GDS operations.

  {
    DOCUMENT: {properties: ['text_embedding']} 
    // This defines the node label to include in the graph. In this case, nodes with the label 'DOCUMENT' are included. 
    // The 'properties' array specifies which properties of the DOCUMENT nodes to load into the graph. 
  },

  {
    MENTIONS: {type: 'MENTIONS', properties: ['total_tfidf_score']},
    // This defines a relationship type to include in the graph, specifically relationships of type 'MENTIONS'. 
    // The 'properties' array for this relationship type includes 'total_tfidf_score', suggesting that each MENTIONS relationship 
    // has an associated TF-IDF score, which might represent the importance or relevance of the mention in context.

    MENTIONED_ON: {type: 'MENTIONED_ON', properties: ['total_tfidf_score']}
    // Similar to the 'MENTIONS' relationship, this defines another relationship type called 'MENTIONED_ON' to be included. 
    // It also focuses on the 'total_tfidf_score' property for these relationships, indicating the relevance score of the mentions within whatever context 'MENTIONED_ON' represents.
  }
)
YIELD graphName, nodeCount, relationshipCount
// After projecting the graph, the 'YIELD' part returns information about the newly created in-memory graph. 
// 'graphName' returns the name of the graph ('documentGraph' in this case).
// 'nodeCount' returns the number of nodes included in the graph.
// 'relationshipCount' returns the number of relationships included in the graph.
