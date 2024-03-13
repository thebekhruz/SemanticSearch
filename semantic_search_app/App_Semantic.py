import streamlit as st
from semantic_search_app.db.DatabaseManager import Neo4jConnection, Neo4jConnector
from ui.results_displayer import ResultsDisplayer
from ui.container_ui import ContainerUI

import pandas as pd
from sentence_transformers import SentenceTransformer, util
import spacy

st.set_page_config(page_title="Document Search",
                    page_icon=":mag:",
                    layout="wide",
                    initial_sidebar_state="expanded")

class App:

    def __init__(self):
        """Initializes the application, ensuring the database connection is established."""
        self.model = SentenceTransformer("msmarco-distilbert-dot-v5")
        self.nlp = spacy.load("en_core_web_sm")  # Load the small English model
        self.driver = None


    def display_search_input(self):
        query = st.text_input('Input your query here:')
        return query


    def preprocess_text(self, query):
        doc = self.nlp(query)
        tokens = [token.lemma_.lower() for token in doc if not token.is_stop and not token.is_punct]
        preprocessed_text = ' '.join(tokens)
        return preprocessed_text


    def encode_text(self, preprocessed_query):
        return self.model.encode([preprocessed_query])
        


    def search_sidebar(self):
        st.sidebar.header("Semantic Search")
        query = st.sidebar.text_input('Input your query here:')
        return self.encode_text(self.preprocess_text(query))



    def semantic_search(self, query_embedding):
        cypher_query = """
            MATCH (d:DOCUMENT)
            RETURN d AS document,
                 gds.similarity.cosine($queryEmbedding, d.text_embedding) AS similarity
            ORDER BY similarity DESC
            LIMIT 10
            """

        try:
            uri = st.secrets["neo4j"]["uri"]
            user = st.secrets["neo4j"]["username"]
            pwd = st.secrets["neo4j"]["password"]

            # Initialize and connect
            self.driver = Neo4jConnection(uri, user, pwd)
            self.driver.connect()

            # Pass the query embedding directly in the correct format
            results = self.driver.run_query(cypher_query, parameters={"queryEmbedding": query_embedding[0].tolist()})
            return results
            # self.display_results(results)

        except Exception as e:
            st.error(f"Failed to create the driver: {e}")




    def prepare_and_display_table_data(self, results):
        """Prepares data for tabular display and allows user interaction for document selection."""
        # Prepare the table data
        data = {
            "Document ID": [],
            "Title": [],
            "Similarity": []
        }

        for record in results:
            document = record.get("document")
            similarity = record.get("similarity", 0)  # Default similarity to 0 if not present
            data["Document ID"].append(document["doc_id"])
            title_text = document["text"][:100] + "..." if len(document["text"]) > 50 else document["text"]
            data["Title"].append(title_text)
            data["Similarity"].append(similarity)
        
        # Convert the data dictionary to a DataFrame for easy tabular display
        df = pd.DataFrame(data)
        
        # Display the DataFrame using Streamlit
        st.dataframe(df, width=1000, height=500, use_container_width=True)

        # User interaction for selecting a document ID
        return df
        





    def _main(self):
        query_vectorised = self.search_sidebar()


        # Perform semantic search
        results = self.semantic_search(query_vectorised)

        # Display results
        df = self.prepare_and_display_table_data( results)

        selected_doc_id = st.sidebar.selectbox("Select a Document ID:", df["Document ID"].tolist())
        if st.sidebar.button("Retrieve Similar Documents"):
            # Placeholder for where you would call run_knn(selected_doc_id) or similar function
            st.sidebar.write(f"Retrieving documents similar to Document ID: {selected_doc_id}")
            # For now, just a placeholder message is shown
            st.sidebar.write("Similar documents would be displayed here.")














if __name__ == "__main__":
    app = App()
    app._main()
