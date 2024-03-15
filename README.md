# SemanticSearch


To run this app make sure to create a virtual environemnt and isntall and the necessary packages.


If you dont have .streamlit folder on your operating system inside this folder:
You will also have to add .streamlit folder and write those secrets inside the secrerts.toml folder.
[neo4j]
uri = "bolt://localhost:7687"
username = "neo4j"
password = "codingRules"

# SemanticSearch

SemanticSearch is a Streamlit-based web application that leverages the power of semantic search to explore and retrieve information from a Neo4j database. This application uses natural language processing to understand the intent behind user queries and provide relevant search results from the connected database.

## Getting Started

Follow these instructions to set up SemanticSearch on your local environment.

### Prerequisites

Before running the application, you'll need to have Python installed on your system. This project is tested on Python 3.8 and above.

### Setting Up a Virtual Environment

It's recommended to run Python projects in a virtual environment to manage dependencies effectively. To create and activate a virtual environment, follow these steps:

1. Open a terminal or command prompt.
2. Navigate to the project's root directory.
3. Run the following command to create a virtual environment:

```bash
python -m venv venv
```


### Configuring Neo4j Database Connection

SemanticSearch requires access to a Neo4j database. Ensure you have Neo4j installed and running. Follow the instructions [here](https://neo4j.com/docs/) for setting up Neo4j.

#### Setting Up Streamlit Secrets for Neo4j

Streamlit apps can use secrets management to securely store and access sensitive information like database credentials. You'll need to configure these details for the app to connect to your Neo4j database:

1. On your operating system, navigate to your home directory.
2. Check if a `.streamlit` directory exists. If not, you will need to create it:

    And add the following code:
    ```bash
    [neo4j]
    uri = "bolt://localhost:7687"
    username = "neo4j"
    password = "codingRules"
    ```


### Running the Application
```bash
streamlit run semantic_search_app/App.py    
```

Thank you.
