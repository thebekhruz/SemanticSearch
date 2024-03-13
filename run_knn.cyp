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


CALL gds.knn.write(
    'documentGraph', // Specifies the name of the in-memory graph to use for the kNN algorithm. This graph should have been previously created and loaded into memory.

    {
        nodeLabels: ['DOCUMENT'], 
        // Specifies the label of the nodes to consider in the kNN computation. 
        // In this case, only nodes labeled 'DOCUMENT' are used.

        nodeProperties: ['text_embedding'], 
        // Specifies the node properties to use for the kNN computation. 
        // Here, 'text_embedding' properties of 'DOCUMENT' nodes are used, 
        // likely representing vector embeddings of documents for calculating similarity.

        writeRelationshipType: 'SIMILAR', 
        // Specifies the type of relationship to create between similar nodes found by the kNN algorithm. 
        // Here, a relationship type 'SIMILAR' will be created between nodes that are deemed to be nearest neighbors.

        writeProperty: 'score', 
        // Specifies the property name to write on each 'SIMILAR' relationship, 
        // which will hold the similarity score between the connected nodes.

        topK: 10, 
        // Defines the number of nearest neighbors to find for each node. 
        // Here, the algorithm will find and create relationships to the 10 most similar nodes for each 'DOCUMENT' node.

        concurrency: 4, 
        // Sets the number of concurrent threads to use for the computation. 
        // A higher number can speed up the process but requires more resources.

        sampleRate: 1.0, 
        // Defines the fraction of nodes to sample for the algorithm. 
        // A rate of 1.0 means all nodes are considered.

        maxIterations: 100
        // Specifies the maximum number of iterations for the algorithm to run. 
        // This is relevant for the iterative process of finding nearest neighbors.
    }
)
YIELD nodesCompared, relationshipsWritten
// After executing the kNN algorithm, the 'YIELD' part returns two pieces of information:
// 'nodesCompared' returns the number of nodes for which nearest neighbors were searched.
// 'relationshipsWritten' returns the number of 'SIMILAR' relationships created between nodes based on their similarity.
