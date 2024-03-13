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
        if self._driver is None:
            self._driver = GraphDatabase.driver(self._uri, auth=(self._user, self._pwd))
            st.success("Connected to Neo4j successfully!")
        else:
            st.warning("Already connected to Neo4j.")

    def close(self):
        """Closes the connection to the Neo4j database."""
        if self._driver is not None:
            self._driver.close()
            self._driver = None
            st.info("Connection to Neo4j closed.")
        else:
            st.warning("No active connection to close.")

    def run_query(self, query, parameters=None, db=None):
        """Executes a Cypher query against the Neo4j database."""
        if self._driver is None:
            raise Exception("Driver not initialized!")
        with (self._driver.session(database=db) if db else self._driver.session()) as session:
            return list(session.run(query, parameters))
