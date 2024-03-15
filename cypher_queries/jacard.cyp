// STEP 1 //
CALL gds.graph.project('jaccard_similarity' , ['*'] , ['*'])

// STEP 2 //
CALL gds.nodeSimilarity.write('jaccard_similarity',{
    writeRelationshipType: 'SIMILAR_jaccard',
    writeProperty: 'score_jaccard',
    topK:5,
    degreeCutoff: 3
})
YIELD nodesCompared, relationshipsWritten
RETURN nodesCompared, relationshipsWritten
