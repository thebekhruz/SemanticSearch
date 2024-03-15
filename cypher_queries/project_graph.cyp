CALL gds.knn.write(
    'documentGraph',
    {
        nodeLabels: ['Document'],
        nodeProperties: ['text_embedding'], // Assuming 'text_embedding' is the property you intend to use
        writeRelationshipType: 'SIMILAR',
        writeProperty: 'score',
        topK: 10, // Define the number of similar nodes to find per node, assuming you need it
        concurrency: 4,
        sampleRate: 1.0,
        maxIterations: 100
    }
)
YIELD nodesCompared, relationshipsWritten



CALL gds.graph.project(
  'documentGraph',
  {
    Document: { 
      label: 'Document', 
      properties: ['text_embedding']
    }
  },
['refers_to','references','HAS_PARENT']
)
YIELD graphName, nodeCount, relationshipCount
