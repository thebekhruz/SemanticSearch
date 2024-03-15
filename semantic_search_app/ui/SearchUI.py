import streamlit as st

class SearchUI:
    @staticmethod
    def display_search_input():

        query = st.text_input('Input your query here:')
        return query



    def search_sidebar():
        with st.sidebar:
            st.sidebar.header('Search')
            query = st.sidebar.text_input('Enter your search query', help="Enter keywords, phrases, or questions related to the content you're looking for.")

            st.sidebar.info("""
                            This is a semantic search tool that helps you find relevant content based on your query. 
                            
                            **How to use:**
                            - Enter your search query in the search box.
                            - Press enter or the search button.
                            - Browse through the results displayed on the main page.
                            
                            **Features:**
                            - Semantic understanding of queries.
                            - Direct connection to a knowledge database.
                            - Intuitive results presentation.

                            **Nearest Neighbour Search:**
                            - Includes two versions of the search algorithm.
                            - KNN Search
                            - Path Similarity
                        """)


            # st.selectbox("Select the search type", ["KNN Search", "Path Similarity"])
            
        return query


    
    @staticmethod
    def display_results(df):
        st.dataframe(df, width=1000, height=500, use_container_width=True)
