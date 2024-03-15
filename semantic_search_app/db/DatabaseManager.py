import streamlit as st
from neo4j import GraphDatabase

class DatabaseManager:
    """Handles the connection to Neo4j database and runs queries."""

    def __init__(self, uri, user, pwd):
        self._uri = uri
        self._user = user
        self._pwd = pwd
        self._driver = None

    def connect(self):
        """Establishes a connection to the Neo4j database."""
        sidebar = st.sidebar
        if self._driver is None:
            self._driver = GraphDatabase.driver(self._uri, auth=(self._user, self._pwd))
            sidebar.success("Connected to Neo4j successfully!",  icon="✅")
        else:
            sidebar.warning("Already connected to Neo4j.")

    def close(self):
        """Closes the connection to the Neo4j database."""
        sidebar = st.sidebar

        if self._driver is not None:
            self._driver.close()
            self._driver = None
            sidebar.info("Connection to Neo4j closed.")
        else:
            sidebar.warning("No active connection to close.")

    def run_query(self, query, parameters=None, db=None):
        """Executes a Cypher query against the Neo4j database."""
        sidebar = st.sidebar
        if self._driver is None:
                sidebar.error("Driver not initialized! Please check your database connection settings.")
                return None
        
        try:
            with (self._driver.session(database=db) if db else self._driver.session()) as session:
                results =list(session.run(query, parameters))
            
                # If the results are empty, raise an error and inform a user
                if not results:
                    st.warning("No results found. Please check your query for correctness and try again.", icon="⚠️")

                else:
                    st.success(f"Query executed successfully.",  icon="✅")
                    return results
        except Exception as e:
            sidebar.error(f"Query failed:")
            return None
