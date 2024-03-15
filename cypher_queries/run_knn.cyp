CALL gds.knn.write(
    'documentGraph',
    {
        nodeLabels: ['DOCUMENT'],
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



// Example
CALL gds.knn.stream(
    'documentGraph',
    {
        topK: 10,
        randomSeed: 42,
        sampleRate: 1.0,
        similarityCutoff: 0.8
    }
)
YIELD sourceNode, targetNode, similarity
RETURN gds.util.asNode(sourceNode).id AS sourceNodeId, gds.util.asNode(targetNode).id AS targetNodeId, similarity






CALL gds.graph.project(
  'documentGraph',
  {
    Document: { 
      label: 'Document', 
      properties: ['doc_id', 'text_embedding'] 
    },
    PERSON: { 
      label: 'PERSON'
    },
    ORGANISATION: { 
      label: 'ORGANISATION'
    },
    LOCATION: { 
      label: 'LOCATION'
    },
    MISCELLANEOUS: { 
      label: 'MISCELLANEOUS'
    }
  },
  {
    refers_to: { 
      type: 'refers_to'
    },
    references: { 
      type: 'references'
    },
    HAS_PARENT: { 
      type: 'HAS_PARENT'
    }
  }
)
YIELD graphName, nodeCount, relationshipCount
