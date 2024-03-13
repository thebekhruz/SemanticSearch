import streamlit as st
from db.DatabaseManager import DatabaseManager
from text_processor.TextProcessor import TextProcessor
from search.SemanticSearch import SemanticSearch
from results.ResultsViewer import ResultsViewer

from ui.SearchUI import SearchUI

class App:
    def __init__(self):
        uri = st.secrets["neo4j"]["uri"]
        user = st.secrets["neo4j"]["username"]
        pwd = st.secrets["neo4j"]["password"]
        self.db_manager = DatabaseManager(uri, user, pwd)
        self.text_processor = TextProcessor()
        self.search = SemanticSearch(self.text_processor, self.db_manager)

    def _main(self):
        self.db_manager.connect()
        query = SearchUI.search_sidebar()
        results = self.search.semantic_search(query)
        
        results_viewer = ResultsViewer(results, search_engine=self.search)
        results_viewer.display_table()
        # Process and display results, similar to prepare_and_display_table_data
        # This would likely involve converting results to a DataFrame and then displaying them

if __name__ == "__main__":
    st.set_page_config(page_title="Document Search", page_icon=":mag:", layout="wide", initial_sidebar_state="expanded")
    app = App()
    app._main()


