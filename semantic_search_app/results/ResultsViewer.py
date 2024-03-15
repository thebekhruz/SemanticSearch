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
        try:
        # Process each result record
            for record in self.results:
                document = record.get("document")
                similarity = record.get("similarity", 0)
                data["Document ID"].append(document["doc_id"])
                title_text = document["text"][:200] + "..." if len(document["text"]) > 200 else document["text"]
                data["Title"].append(title_text)
                data["Similarity"].append(similarity)
            
            return pd.DataFrame(data)
        
        except Exception as e:
            st.warning(f"An error occurred while processing the results: {e}", icon="⚠️")
            return pd.DataFrame()

    def _configure_grid_options(self, df):
        """Configures grid options for the AgGrid display."""
        gb = GridOptionsBuilder.from_dataframe(df)
        gb.configure_pagination()                   # Enable pagination
        gb.configure_side_bar()                     # Enable the side bar for filtering
        gb.configure_selection('single')            # Enable selection of single rows
        # gb.configure_selection(selection_mode='multiple', use_checkbox=True)  # Enable selection of multiple rows

        gb.configure_column("Document ID", hide=True)  # Hide the Document ID column in the table

        # Adjust column sizes - using flex as a proxy for percentage-based widths
        gb.configure_column("Title", flex=4)  # Higher flex value for more space
        gb.configure_column("Similarity", flex=1)  # Lower flex value to reduce space

        return gb.build()

    def display_table(self):
        """Displays an interactive table using AgGrid and handles user interaction."""
        sidebar =st.sidebar 
        algorithm =sidebar.selectbox("Select the search type", ["KNN Search", "Path Similarity"])


        df = self._create_data_frame()
        grid_options = self._configure_grid_options(df)

        # Display the DataFrame with AgGrid
        response = AgGrid(df, gridOptions=grid_options, enable_enterprise_modules=True, height=500, width='100%',
                                fit_columns_on_grid_load=True, update_mode='MODEL_CHANGED')
        
            

        if st.button("Find Simmilar Entities", key="run_button", use_container_width=True):
            # Check if a row is selected and perform an action
            selected = response['selected_rows']
            if selected:
                if algorithm =='KNN Search':
                    selected_row = selected[0]
                    document_id = selected_row['Document ID']
                    self.handle_knn_search(document_id)
                if algorithm =='Path Similarity':
                    selected_row1 = selected[0]
                    document_id1 = selected_row1['Document ID']
                    self.handle_path_similarity(document_id1)




        return df

    def handle_path_similarity(self, document_id):
        path_similarity_results = self.search.run_path_similarity(document_id)
        st.subheader(f"Found similar documents based on Jaccard Simmilarity ")
        # Check if path similarity results are empty
        if not path_similarity_results:
            st.warning("No path similarity results found.", icon="⚠️")
            st.info("Try populating your data with more data.", icon="ℹ️")
        else:
            self.display_path_similarity_results(path_similarity_results)


    def handle_knn_search(self, document_id):
        knn_results = self.search.run_knn(document_id)
        st.subheader(f"Found similar documents based on k-NN search for document ID: ")
        self.display_knn_results(knn_results)





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
        

    def display_path_similarity_results(self, knn_results):
        """Displays kNN results in a table format."""
        knn_data = []
        for result in knn_results:
            doc1, doc2, relationship = result['doc1'], result['doc2'], result['r1']
            knn_data.append({
                "Document ID": doc2["doc_id"],
                "Document Text": doc2["text"][:100],
                "Similarity Score": relationship["score_jaccard"]
            })
        knn_df = pd.DataFrame(knn_data)
        gb = GridOptionsBuilder.from_dataframe(knn_df)
        gb.configure_pagination()
        gb.configure_side_bar()
        gb.configure_selection('single', use_checkbox=True)
        grid_options = gb.build()
        AgGrid(knn_df, gridOptions=grid_options, enable_enterprise_modules=True, width='100%',
               fit_columns_on_grid_load=True, height=500, update_mode='MODEL_CHANGED')

