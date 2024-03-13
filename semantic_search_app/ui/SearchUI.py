import streamlit as st

class SearchUI:
    @staticmethod
    def display_search_input():
        query = st.text_input('Input your query here:')
        return query



    def search_sidebar():
        st.header("Select a search engine, aka document embedding model")
        tab1, tab2, tab3, tab4 = st.tabs(["Sentence Transformers", "Word2Vec", "node2Vec", "Help"])

        with st.sidebar:
            st.header("Search Settings")
            query = st.text_input('Input your query here:', key="query_input")
            
            # You could add more sidebar settings here that apply globally across tabs

        if tab1:
            st.header("Semantic Search with Sentence Transformers model")
            # Place the content specific to Sentence Transformers here
            st.write("Enter your query in the sidebar to search with Sentence Transformers.")

        # Repeat similar structures for tab2, tab3 as needed

        if tab4:
            st.header("Help")
            st.write("""
                    Here are some tips to enhance your experience:
                    - Use the sidebar filters to narrow down your search.
                    - Click on any document to see similar ones.
                    - Adjust pagination at the bottom to control the number of rows displayed.
                    """)

        st.info("ℹ️ Click on a row to see similar documents based on the k-NN search.")
        return query


    
    @staticmethod
    def display_results(df):
        st.dataframe(df, width=1000, height=500, use_container_width=True)
