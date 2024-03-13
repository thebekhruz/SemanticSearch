from text_processor.TextProcessor import TextProcessor

class SemanticSearch:

    def __init__(self, text_processor, db_manager):
        self.text_processor = text_processor
        self.db_manager = db_manager

    def semantic_search(self, query):

        preprocessed_query = self.text_processor.preprocess_text(query)
        query_embedding = self.text_processor.encode_text(preprocessed_query)
        
        cypher_query = """
        MATCH (d:DOCUMENT)
        RETURN d AS document,
             gds.similarity.cosine($queryEmbedding, d.text_embedding) AS similarity
        ORDER BY similarity DESC
        LIMIT 10
        """
        
        return self.db_manager.run_query(cypher_query, {"queryEmbedding": query_embedding[0].tolist()})



    def run_knn(self, selected_doc_id):
        # Cypher Query to match similar documents
        # Knn is performed seperatlly in the neo4j app.
        cypher_query = """
        MATCH (doc1:DOCUMENT)-[r1:SIMILAR]->(doc2)
        WHERE doc1.doc_id = $doc_id
        RETURN doc1, r1, doc2
        LIMIT 10
        """

        return self.db_manager.run_query(cypher_query, {"doc_id": selected_doc_id})

        