import streamlit as st
import pandas as pd
from st_aggrid import AgGrid, GridOptionsBuilder

class ResultsViewer:
    def __init__(self, results):
        self.results = results


import streamlit as st
from st_aggrid import AgGrid, GridOptionsBuilder
import pandas as pd

class ResultsViewer:
    def __init__(self, results, search_engine):
        self.results = results
        self.search = search_engine

    def _create_data_frame(self):
        """Extracts data from results and creates a pandas DataFrame."""
        # Initialize a dictionary to store data
        data = {
            "Document ID": [],
            "Title": [],
            "Similarity": []
        }

        # Process each result record
        for record in self.results:
            document = record.get("document")
            similarity = record.get("similarity", 0)
            data["Document ID"].append(document["doc_id"])
            title_text = document["text"][:100] + "..." if len(document["text"]) > 50 else document["text"]
            data["Title"].append(title_text)
            data["Similarity"].append(similarity)
        
        return pd.DataFrame(data)

    def _configure_grid_options(self, df):
        """Configures grid options for the AgGrid display."""
        gb = GridOptionsBuilder.from_dataframe(df)
        gb.configure_pagination()                   # Enable pagination
        gb.configure_side_bar()                     # Enable the side bar for filtering
        gb.configure_selection('single')            # Enable selection of single rows
        return gb.build()

    def display_table(self):
        """Displays an interactive table using AgGrid and handles user interaction."""
        
        df = self._create_data_frame()
        grid_options = self._configure_grid_options(df)



        # Display the DataFrame with AgGrid
        response = AgGrid(df, gridOptions=grid_options, enable_enterprise_modules=True, height=500, width='100%',
                                fit_columns_on_grid_load=True, update_mode='MODEL_CHANGED')
        
        # Check if a row is selected and perform an action
        selected = response['selected_rows']
        if selected:
            selected_row = selected[0]
            document_id = selected_row['Document ID']
            self._handle_selected_document(document_id)

        return df


    def display_knn_results(self, knn_results):
        """Displays kNN results in a table format."""
        knn_data = []
        for result in knn_results:
            doc1, doc2, relationship = result['doc1'], result['doc2'], result['r1']
            knn_data.append({
                "Document ID": doc2["doc_id"],
                "Document Text": doc2["text"][:100],
                "Similarity Score": relationship["score"]
            })
        knn_df = pd.DataFrame(knn_data)
        gb = GridOptionsBuilder.from_dataframe(knn_df)
        gb.configure_pagination()
        gb.configure_side_bar()
        gb.configure_selection('single', use_checkbox=True)
        grid_options = gb.build()
        AgGrid(knn_df, gridOptions=grid_options, enable_enterprise_modules=True, width='100%',
               fit_columns_on_grid_load=True, height=500, update_mode='MODEL_CHANGED')

    def _handle_selected_document(self, document_id):
        """Handles the event when a document is selected."""
        knn_results = self.search.run_knn(document_id)
        st.header(f"Found similar documents based on k-NN search for document ID: ...{document_id[-6:]}")
        self.display_knn_results(knn_results)
